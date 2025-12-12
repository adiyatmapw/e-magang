from flask import Flask, render_template, request, redirect, url_for, session, flash, send_file
from models import db, User, DataPeserta, BerkasPeserta, StatusPendaftaran, DataBerkasHC, Logbook, SertifikatMagang, LogAktivitas
from werkzeug.utils import secure_filename
from datetime import timedelta, datetime
import logging, os, json, random
from io import BytesIO
from fpdf import FPDF
from sqlalchemy import Text, and_, func, or_


logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
app = Flask(__name__)
app.secret_key = 'your_secret_key'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/dbprakerin'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.permanent_session_lifetime = timedelta(minutes=30)
# Konfigurasi folder upload dan ekstensi yang diizinkan
UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = {'pdf', 'png', 'jpg', 'jpeg'}
MAX_FILE_SIZE = 2 * 1024 * 1024  # 2 MB
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def save_file(file):
    if file and allowed_file(file.filename):
        if file.content_length > MAX_FILE_SIZE:
            raise ValueError('File terlalu besar. Maksimum 2 MB.')
        
        filename = secure_filename(file.filename)
        file_path = os.path.join('uploads', secure_filename(file.filename))
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(file.filename)))
        return file_path
    else:
        raise ValueError('Format file tidak valid.')

# Inisialisasi database
db.init_app(app)

# Route halaman login
@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        # Cari user berdasarkan email
        user = User.query.filter_by(email=email).first()

        if user and user.password == password:
            session['user_id'] = user.id
            session['user_role'] = user.roles
            session['user_name'] = user.email
            session['nama'] = user.nama
            session['nohp'] = user.nohp
            session.permanent = True  # Set session permanen sesuai waktu di atas

            flash('Login berhasil!', 'success')

            # Redirect sesuai role user
            if user.roles == 'HC Admin':
                return redirect(url_for('homeadmin'))
            elif user.roles == 'PAM Admin':
                return redirect(url_for('homeadmin'))
            elif user.roles == 'Peserta':
                return redirect(url_for('homepeserta'))
        else:
            flash('Email atau password salah!', 'danger')
            return redirect(url_for('login'))

    return render_template('login.html')

@app.route('/forgot-password', methods=['GET', 'POST'])
def forgot_password():
    if request.method == 'POST':
        email = request.form.get('email')
        # TODO: Di masa depan, lakukan pengecekan email dan kirim link jika memungkinkan
        flash('Link telah dikirim, silahkan periksa email Anda.', 'success')
        return redirect(url_for('login'))

    return render_template('forgot-password.html')


@app.context_processor
def inject_status_daftar():
    user_id = session.get('user_id')
    if user_id:
        peserta = DataPeserta.query.filter_by(id_user=user_id).first()
        if peserta:
            status = StatusPendaftaran.query.filter_by(id_peserta=peserta.id).first()
            return {'status_daftar': status.status_daftar if status else None}
    return {'status_daftar': None}


# Route halaman registrasi
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        fullname = request.form['fullname']
        nik = request.form['nik']
        phone = request.form['phone']
        email = request.form['email']
        password = request.form['password']
        confirm_password = request.form['confirmPassword']

        # Validasi: cek duplikat NIK
        existing_nik = User.query.filter_by(nik=nik).first()
        if existing_nik:
            flash('NIK sudah terdaftar.', 'danger')
            return redirect(url_for('register'))
        
        # Validasi: cek duplikat Email
        existing_email = User.query.filter_by(email=email).first()
        if existing_email:
            flash('Email sudah terdaftar. Silahkan gunakan email lain.', 'danger')
            return redirect(url_for('register'))
        
        # Validasi: Password dan Konfirmasi Password harus sama
        if password != confirm_password:
            flash('Password dan Konfirmasi Password tidak cocok!', 'danger')
            return redirect(url_for('register'))

        # Tetapkan role sebagai 'Peserta'
        role = 'Peserta'

        try:
            # Buat user baru di tabel User dengan kolom nama dan nohp
            new_user = User(
                email=email,
                password=password,
                roles=role,
                nama=fullname,
                nohp=phone,
                nik=nik
            )
            db.session.add(new_user)
            db.session.commit()

            # ✅ Tambahkan log aktivitas setelah commit berhasil
            from helpers import log_aktivitas
            log_aktivitas(
                actor_id=new_user.id,               # ID user yang baru saja dibuat
                role_actor=new_user.roles,          # Role user tersebut
                aktivitas='Registrasi Akun',
                deskripsi=f'User {fullname} melakukan registrasi akun',
                target_user_id=new_user.id          # Karena dia yang melakukan dan dia juga yang terdampak
            )
            # Beri notifikasi sukses dan redirect ke halaman login
            flash('Registrasi akun berhasil dilakukan. Silakan login.', 'success')
            return redirect(url_for('login'))

        except Exception as e:
            db.session.rollback()
            flash(f'Terjadi kesalahan saat registrasi: {str(e)}', 'danger')
            return redirect(url_for('register'))

    return render_template('register.html')


# Route halaman utama peserta
@app.route('/homepeserta')
def homepeserta():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta untuk mengakses halaman ini.', 'warning')
        return redirect(url_for('login'))
    
        # Ambil status pendaftaran peserta
    peserta_status = db.session.query(StatusPendaftaran.status_daftar)\
        .join(DataPeserta, StatusPendaftaran.id_peserta == DataPeserta.id)\
        .filter(DataPeserta.id_user == session.get('user_id')).first()

    status_daftar = peserta_status.status_daftar if peserta_status else None

    return render_template('home-peserta.html', user_name=session.get('user_name'), status_daftar=status_daftar)

@app.route('/daftarmagang', methods=['GET', 'POST'])
def daftarmagang():
    user_id = session.get('user_id')
    logger.debug(f"User ID dari session: {user_id}")

    # Periksa apakah user sudah login
    if not user_id:
        flash('Silakan login terlebih dahulu.', 'warning')
        return redirect(url_for('login'))
    # Cek status pendaftaran user
    status_pendaftaran = StatusPendaftaran.query.join(DataPeserta).filter(DataPeserta.id_user == user_id).first()
    
    if status_pendaftaran:
        status = status_pendaftaran.status_daftar
        status_berkas = status_pendaftaran.status_berkas
        id_peserta = status_pendaftaran.id_peserta 
        logger.debug(f"Status pendaftaran ditemukan: {status}, ID Peserta: {id_peserta}")
        
        # Redirect berdasarkan status pendaftaran
        if status == 'Perlu Diseleksi':
            return redirect(url_for('prosesseleksi'))
        elif status == 'Kel. Berkas':
            if status_berkas == 'Menunggu Peserta':
                return redirect(url_for('kelengkapanberkas', id=id_peserta))
            elif status_berkas == 'Revisi':
                return redirect(url_for('kelengkapanberkas_revisi', id=id_peserta))
            elif status_berkas == 'Revisi Selesai':
                return redirect(url_for('kelengkapanberkasuploaded'))
            elif status_berkas == 'Sedang Diproses':
                return redirect(url_for('kelengkapanberkasuploaded'))
        elif status == 'Wawancara':
            if status_berkas == 'Tanggal Sudah Ditentukan':
                return redirect(url_for('wawancara', id=id_peserta))
            elif status_berkas == 'Menentukan Tanggal':
                return redirect(url_for('kelengkapanberkasuploaded'))
        elif status in ['Diterima', 'Ditolak']:
            return redirect(url_for('pengumuman', id=id_peserta))
            
    if request.method == 'GET':
        user = User.query.filter_by(id=user_id).first()

        if not user:
            flash('Data user tidak ditemukan.', 'danger')
            return redirect(url_for('login'))

        return render_template('daftarmagang.html', user=user)    
    
    elif request.method == 'POST':
        try:
            logger.debug("Memulai proses pendaftaran magang...")
            # Mengambil data dari form
            user_id = session.get('user_id')
            user = User.query.filter_by(id=user_id).first()
            if not user:
                flash('Data user tidak ditemukan.', 'danger')
                return redirect(url_for('login'))
            semester = request.form['semester']
            asal_kampus = request.form['campus']
            jenis_kelamin = request.form['gender']
            jenjang = request.form['jenjang']
            tempat_lahir = request.form['birthplace']
            tanggal_lahir = request.form['birthdate']
            tanggal_dimulai = request.form['startDate']
            tanggal_berakhir = request.form['endDate']
            logger.debug(f"Data form: {semester}, {asal_kampus}, {jenis_kelamin}, {tempat_lahir}, {tanggal_lahir}, {tanggal_dimulai}, {tanggal_berakhir}")

            # Membuat entri baru di tabel data_peserta
            peserta = DataPeserta(
                id_user=user_id,
                nama=user.nama,
                nohp=user.nohp,
                semester=semester,
                asal_kampus=asal_kampus,
                jenjang_pendidikan=jenjang,
                tempat_lahir=tempat_lahir,
                tanggal_lahir=tanggal_lahir,
                jenis_kelamin=jenis_kelamin,
                tanggal_dimulai=tanggal_dimulai,
                tanggal_berakhir=tanggal_berakhir,
                nama_pembimbing=None,
                nohp_pembimbing=None
            )
            db.session.add(peserta)
            db.session.commit()
            logger.debug(f"Data peserta berhasil disimpan dengan ID: {peserta.id}")

            # Membuat entri di tabel status_pendaftaran
            status = StatusPendaftaran(
                id_peserta=peserta.id,
                status_daftar='Perlu Diseleksi',
                status_berkas='Sedang Diproses'
            )
            db.session.add(status)
            db.session.commit()
            logger.debug("Status pendaftaran berhasil disimpan.")

            # Menghandle file upload dan menyimpan path file ke tabel berkas_peserta
            file_paths = {}
            file_fields = {
                'surat_pengantar_magang': 'file1',
                'proposal_magang': 'file2',
                'curriculum_vitae': 'file3'
            }

            for field_name in file_fields.keys():
                uploaded_file = request.files.get(field_name)
                if uploaded_file and uploaded_file.filename:
                    file_paths[field_name] = save_file(uploaded_file)
                    logger.debug(f"File {field_name} berhasil diupload: {file_paths[field_name]}")


            berkas = BerkasPeserta(
                id_peserta=peserta.id,
                surat_pengantar_magang=file_paths.get('surat_pengantar_magang'),
                proposal_magang=file_paths.get('proposal_magang'),
                curriculum_vitae=file_paths.get('curriculum_vitae')
            )
            db.session.add(berkas)
            db.session.commit()
            logger.debug(f"Berkas peserta berhasil disimpan.")

            from helpers import log_aktivitas
            log_aktivitas(
                actor_id=user.id,
                role_actor=user.roles,
                aktivitas='Pendaftaran Magang',
                deskripsi=f'{user.nama} mendaftar program magang dengan asal kampus {asal_kampus}',
                target_user_id=user.id
            )

            flash('Pendaftaran berhasil! Silakan menunggu proses seleksi.', 'success')
            return redirect(url_for('prosesseleksi'))

        except Exception as e:
            db.session.rollback()
            logger.error(f"Terjadi kesalahan: {str(e)}")
            flash(f'Terjadi kesalahan: {str(e)}', 'danger')
            return redirect(url_for('daftarmagang'))

@app.route('/prosesseleksi')
def prosesseleksi():
    return render_template('proses-seleksi.html')

@app.route('/kelengkapanberkas/<int:id>', methods=['GET', 'POST'])
def kelengkapanberkas(id):
    peserta = db.session.query(DataPeserta, BerkasPeserta, StatusPendaftaran)\
        .join(BerkasPeserta, DataPeserta.id == BerkasPeserta.id_peserta)\
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
        .filter(DataPeserta.id == id).first()

    if request.method == 'POST':
        try:
            # Simpan nama dan no hp pembimbing
            peserta.DataPeserta.nama_pembimbing = request.form['nama_pembimbing']
            peserta.DataPeserta.nohp_pembimbing = request.form['nohp_pembimbing']

            # Handle file uploads
            file_fields = {
                'pas_foto': 'pas_foto',
                'surat_sehat': 'surat_sehat',
                'kartu_tanda_mahasiswa': 'kartu_tanda_mahasiswa',
                'ktp': 'ktp',
                'kartu_keluarga': 'kartu_keluarga',
                'sim': 'sim',
                'stnk': 'stnk',
                'skck': 'skck'
            }

            for field_name, column_name in file_fields.items():
                file = request.files.get(field_name)
                if file and file.filename:
                    filename = secure_filename(file.filename)
                    file_path = os.path.join('uploads', secure_filename(file.filename))
                    file.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(file.filename)))
                    setattr(peserta.BerkasPeserta, column_name, file_path)

            # Update status pendaftaran dan status berkas
            peserta.StatusPendaftaran.status_berkas = 'Sedang Diproses'
            peserta.StatusPendaftaran.status_daftar = 'Kel. Berkas'

            db.session.commit()

            from helpers import log_aktivitas
            log_aktivitas(
                actor_id=session['user_id'],
                role_actor='Peserta',
                aktivitas='Upload Kelengkapan Berkas',
                deskripsi='Peserta mengunggah kelengkapan tambahan',
                target_user_id=session['user_id']
            )

            flash('Berkas berhasil diupload dan status pendaftaran diperbarui.', 'success')
            return redirect(url_for('kelengkapanberkasuploaded'))

        except Exception as e:
            db.session.rollback()
            flash(f'Terjadi kesalahan: {e}', 'danger')

    return render_template('kelengkapan-berkas.html', peserta=peserta)

@app.route('/kelengkapanberkas-revisi/<int:id>', methods=['GET', 'POST'])
def kelengkapanberkas_revisi(id):
    peserta = db.session.query(DataPeserta, StatusPendaftaran, BerkasPeserta)\
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
        .join(BerkasPeserta, DataPeserta.id == BerkasPeserta.id_peserta)\
        .filter(DataPeserta.id == id).first()

    if not peserta:
        flash("Peserta tidak ditemukan", "danger")
        return redirect(url_for('dashboard'))

    data_peserta, status_pendaftaran, berkas_peserta = peserta
    peserta = {
        "DataPeserta": data_peserta,
        "StatusPendaftaran": status_pendaftaran,
        "BerkasPeserta": berkas_peserta
    }
    if request.method == 'POST':
            try:
                # Simpan nama dan no hp pembimbing (jika diedit)
                peserta["DataPeserta"].nama_pembimbing = request.form.get('nama_pembimbing')
                peserta["DataPeserta"].nohp_pembimbing = request.form.get('nohp_pembimbing')

                # Handle file upload hanya untuk field yang ada dalam form
                file_fields = {
                    'pas_foto': 'pas_foto',
                    'surat_sehat': 'surat_sehat',
                    'kartu_tanda_mahasiswa': 'kartu_tanda_mahasiswa',
                    'ktp': 'ktp',
                    'kartu_keluarga': 'kartu_keluarga',
                    'sim': 'sim',
                    'stnk': 'stnk',
                    'skck': 'skck'
                }

                for field_name, column_name in file_fields.items():
                    file = request.files.get(field_name)
                    if file and file.filename:
                        filename = secure_filename(file.filename)
                        file_path = os.path.join('uploads', filename)
                        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                        setattr(peserta["BerkasPeserta"], column_name, file_path)

                # Update status
                peserta["StatusPendaftaran"].status_berkas = 'Revisi Selesai'
                peserta["StatusPendaftaran"].status_daftar = 'Kel. Berkas'

                db.session.commit()

                from helpers import log_aktivitas
                log_aktivitas(
                    actor_id=session['user_id'],
                    role_actor='Peserta',
                    aktivitas='Upload Revisi Berkas',
                    deskripsi='Peserta mengunggah revisi kelengkapan berkas sesuai catatan HC',
                    target_user_id=session['user_id']
                )
                flash('Berkas revisi berhasil dikirim. Status Anda telah diperbarui.', 'success')
                return redirect(url_for('kelengkapanberkasuploaded'))

            except Exception as e:
                db.session.rollback()
                flash(f'Terjadi kesalahan: {e}', 'danger')    

    return render_template("kelengkapanberkas-revisi.html", peserta=peserta)


@app.route('/kelengkapanberkasuploaded')
def kelengkapanberkasuploaded():
    return render_template('kelengkapan-berkas-uploaded.html')

@app.route('/wawancara/<int:id>')
def wawancara(id):
    peserta = db.session.query(DataPeserta, StatusPendaftaran).join(StatusPendaftaran).filter(DataPeserta.id == id).first()
    return render_template('wawancara.html', peserta=peserta)


@app.route('/pengumuman/<int:id>')
def pengumuman(id):
    peserta = (
        db.session.query(DataPeserta, StatusPendaftaran)
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)
        .filter(StatusPendaftaran.id_peserta == id, StatusPendaftaran.status_daftar == 'Diterima')
        .first()
    )
    
    if not peserta:
        flash('Data peserta tidak ditemukan atau status pendaftaran belum diterima.', 'danger')
        return redirect(url_for('homepeserta'))

    data_peserta, status_pendaftaran = peserta
    status_daftar = status_pendaftaran.status_daftar

    return render_template('pengumuman.html', peserta={
        "DataPeserta": data_peserta,
        "StatusPendaftaran": status_pendaftaran
    }, status_daftar=status_daftar)


@app.route('/logbook')
def logbook():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))

    # Ambil data peserta, user, dan status
    result = db.session.query(DataPeserta, User, StatusPendaftaran)\
        .join(User, DataPeserta.id_user == User.id)\
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
        .filter(User.id == session['user_id']).first()

    if not result:
        flash("Data peserta tidak ditemukan.", "danger")
        return redirect(url_for('homepeserta'))

    data_peserta, user, status = result

        # Ambil status pendaftaran peserta
    peserta_status = db.session.query(StatusPendaftaran.status_daftar)\
        .join(DataPeserta, StatusPendaftaran.id_peserta == DataPeserta.id)\
        .filter(DataPeserta.id_user == session.get('user_id')).first()
    
    peserta = {
        "DataPeserta": data_peserta,
        "User": user,
        "StatusPendaftaran": status
    }

    # Ambil logbook peserta
    logbook_entries = db.session.query(Logbook)\
        .filter_by(id_peserta=data_peserta.id)\
        .order_by(Logbook.tanggal_logbook).all()

    status_daftar = peserta_status.status_daftar if peserta_status else None

    return render_template('logbook.html', peserta=peserta, logbook_entries=logbook_entries, status_daftar=status_daftar)


@app.route('/logbook/tambah', methods=['GET', 'POST'])
def tambah_logbook():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))

    peserta = DataPeserta.query.filter_by(id_user=session['user_id']).first()
    if not peserta:
        flash('Data peserta tidak ditemukan.', 'danger')
        return redirect(url_for('homepeserta'))

    count_logbook = Logbook.query.filter_by(id_peserta=peserta.id).count()
    minggu_ke = count_logbook + 1

    if request.method == 'POST':
        minggu_ke_form = request.form.get('minggu_ke')
        tanggal_mulai = request.form.get('tanggal_mulai')
        tanggal_sampai = request.form.get('tanggal_sampai')
        catatan = request.form.get('catatan')
        file = request.files.get('file_logbook')

        try:
            start_date = datetime.strptime(tanggal_mulai, '%Y-%m-%d').date()
            end_date = datetime.strptime(tanggal_sampai, '%Y-%m-%d').date()
        except Exception:
            flash('Tanggal mulai dan sampai harus diisi dengan benar.', 'danger')
            return redirect(request.url)

        if (end_date - start_date).days > 6:
            flash('Rentang tanggal maksimal 7 hari.', 'danger')
            return redirect(request.url)

        # Validasi overlap rentang tanggal
        overlap = Logbook.query.filter(
            Logbook.id_peserta == peserta.id,
            Logbook.tanggal_logbook <= end_date,
            Logbook.tanggal_sampai >= start_date
        ).first()

        if overlap:
            flash('Rentang tanggal yang Anda inputkan tumpang tindih dengan logbook yang sudah ada.', 'danger')
            return redirect(request.url)

        # Validasi file
        if file and file.filename:
            if not allowed_file(file.filename):
                flash('Format file harus PDF atau DOCX.', 'danger')
                return redirect(request.url)

            file.seek(0, 2)
            file_length = file.tell()
            file.seek(0)
            if file_length > MAX_FILE_SIZE:
                flash('Ukuran file maksimal 10 MB.', 'danger')
                return redirect(request.url)

            filename = secure_filename(file.filename)
            file_path = 'uploads/' + filename
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        else:
            file_path = None

        new_logbook = Logbook(
            id_peserta=peserta.id,
            minggu_ke_logbook=int(minggu_ke_form),
            tanggal_logbook=start_date,
            tanggal_sampai=end_date,
            catatan=catatan,
            file_logbook=file_path
        )

        try:
            db.session.add(new_logbook)
            db.session.commit()

            from helpers import log_aktivitas
            log_aktivitas(
                actor_id=session['user_id'],
                role_actor='Peserta',
                aktivitas='Tambah Logbook Mingguan',
                deskripsi=f'Menambahkan logbook minggu ke-{minggu_ke_form}',
                target_user_id=session['user_id']
            )

            flash('Logbook berhasil ditambahkan.', 'success')
            return redirect(url_for('logbook'))
        except Exception as e:
            db.session.rollback()
            flash(f'Terjadi kesalahan saat menyimpan logbook: {e}', 'danger')
            return redirect(request.url)

    return render_template('tambah-logbook.html', peserta=peserta, minggu_ke=minggu_ke)

@app.route('/sertifikat/laporan_magang', methods=['GET', 'POST'])
def laporan_magang():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))

    user_id = session['user_id']
    peserta = DataPeserta.query.filter_by(id_user=user_id).first()
    status_pendaftaran = StatusPendaftaran.query.filter_by(id_peserta=peserta.id).first() if peserta else None
    sertifikat = SertifikatMagang.query.filter_by(id_user=user_id).first()

    # Redirect berdasarkan status_laporan_magang
    if sertifikat:
        status_laporan = sertifikat.status_laporan_magang
        if status_laporan is None:
            # Jika NULL, lanjut tampilkan halaman ini (upload laporan magang)
            pass
        elif status_laporan == 'Sedang Diproses':
            return redirect(url_for('pemeriksaan_logbook'))
        elif status_laporan == 'Revisi Laporan':
            return redirect(url_for('revisi_laporan'))
        elif status_laporan == 'Revisi Sedang Diproses':
            return redirect(url_for('pemeriksaan_logbook'))
        elif status_laporan == 'Tentukan Tanggal Presentasi':
            return redirect(url_for('presentasi_waiting'))
        elif status_laporan == 'Presentasi':
            return redirect(url_for('presentasi_schedule'))
        elif status_laporan in ['Menunggu Sertifikat', 'Sertifikat Tercetak']:
            return redirect(url_for('sertifikat'))

    if request.method == 'POST':
        # Validasi jumlah logbook
        logbook_count = Logbook.query.filter_by(id_peserta=peserta.id).count()
        if logbook_count < 4:
            flash('Silahkan lengkapi Logbook terlebih dahulu, minimal 4 kali pada logbook.', 'danger')
            return redirect(request.url)
        # Ambil file upload
        laporan_file = request.files.get('laporan_magang')
        surat_orisinalitas_file = request.files.get('surat_orisinalitas')
        presentasi_file = request.files.get('presentasi_magang')

        ALLOWED_EXTENSIONS = {'pdf', 'docx'}
        MAX_FILE_SIZE = 10 * 1024 * 1024  # 10MB

        def allowed_file(filename):
            return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

        # Validasi file laporan magang
        if not laporan_file or not laporan_file.filename:
            flash('File laporan magang wajib diunggah.', 'danger')
            return redirect(request.url)
        if not allowed_file(laporan_file.filename):
            flash('Format file laporan magang harus PDF atau DOCX.', 'danger')
            return redirect(request.url)
        laporan_file.seek(0, 2)
        if laporan_file.tell() > MAX_FILE_SIZE:
            flash('Ukuran file laporan magang maksimal 10 MB.', 'danger')
            return redirect(request.url)
        laporan_file.seek(0)

        # Validasi file surat orisinalitas
        if not surat_orisinalitas_file or not surat_orisinalitas_file.filename:
            flash('File surat orisinalitas wajib diunggah.', 'danger')
            return redirect(request.url)
        if not allowed_file(surat_orisinalitas_file.filename):
            flash('Format file surat orisinalitas harus PDF atau DOCX.', 'danger')
            return redirect(request.url)
        surat_orisinalitas_file.seek(0, 2)
        if surat_orisinalitas_file.tell() > MAX_FILE_SIZE:
            flash('Ukuran file surat orisinalitas maksimal 10 MB.', 'danger')
            return redirect(request.url)
        surat_orisinalitas_file.seek(0)

        # Simpan file
        laporan_filename = secure_filename(laporan_file.filename)
        surat_filename = secure_filename(surat_orisinalitas_file.filename)

        upload_folder = app.config['UPLOAD_FOLDER']

        laporan_path = os.path.join(upload_folder, laporan_filename)
        surat_path = os.path.join(upload_folder, surat_filename)

        laporan_file.save(laporan_path)
        surat_orisinalitas_file.save(surat_path)

        # Validasi dan simpan file presentasi jika ada
        presentasi_path = None
        if presentasi_file and presentasi_file.filename:
            if not allowed_file(presentasi_file.filename):
                flash('Format file presentasi harus PDF atau DOCX.', 'danger')
                return redirect(request.url)
            presentasi_file.seek(0, 2)
            if presentasi_file.tell() > MAX_FILE_SIZE:
                flash('Ukuran file presentasi maksimal 10 MB.', 'danger')
                return redirect(request.url)
            presentasi_file.seek(0)

            presentasi_filename = secure_filename(presentasi_file.filename)
            presentasi_path = os.path.join(upload_folder, presentasi_filename)
            presentasi_file.save(presentasi_path)

        # Simpan ke DB
        sertifikat = SertifikatMagang.query.filter_by(id_user=user_id).first()
        if not sertifikat:
            sertifikat = SertifikatMagang(id_user=user_id)

        sertifikat.laporan_magang = 'uploads/' + laporan_filename
        sertifikat.surat_orisinalitas = 'uploads/' + surat_filename
        sertifikat.presentasi_magang = 'uploads/' + presentasi_filename
        sertifikat.status_laporan_magang = 'Sedang Diproses'
        # Simpan judul laporan jika ada, bisa ditambahkan form field jika dibutuhkan

        db.session.add(sertifikat)
        db.session.commit()

        from helpers import log_aktivitas
        log_aktivitas(
            actor_id=session['user_id'],
            role_actor='Peserta',
            aktivitas='Upload Laporan Magang',
            deskripsi='Peserta mengunggah laporan akhir.',
            target_user_id=session['user_id']
        )


        flash('Laporan magang berhasil dikumpulkan.', 'success')
        return redirect(url_for('pemeriksaan_logbook'))

    return render_template('laporan-magang.html', peserta=peserta, status=status_pendaftaran)

@app.route('/sertifikat/pemeriksaan_logbook')
def pemeriksaan_logbook():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))

    user_id = session['user_id']
    peserta = DataPeserta.query.filter_by(id_user=user_id).first()
    status_pendaftaran = StatusPendaftaran.query.filter_by(id_peserta=peserta.id).first() if peserta else None

    # Pastikan status laporan magang sudah 'Dikirim'
    sertifikat = SertifikatMagang.query.filter_by(id_user=user_id).first()

    return render_template('pemeriksaan-logbook.html', peserta=peserta, status=status_pendaftaran)

@app.route('/sertifikat/revisi_laporan', methods=['GET', 'POST'])
def revisi_laporan():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))

    user_id = session['user_id']
    peserta = DataPeserta.query.filter_by(id_user=user_id).first()
    sertifikat = SertifikatMagang.query.filter_by(id_user=user_id).first()

    if not peserta or not sertifikat:
        flash('Data peserta tidak ditemukan.', 'danger')
        return redirect(url_for('homepeserta'))

    if request.method == 'POST':
        file = request.files.get('laporan_magang_revisi')
        if file and file.filename:
            from werkzeug.utils import secure_filename
            filename = secure_filename(file.filename)
            file_path = 'uploads/' + filename
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            sertifikat.laporan_magang = file_path
            sertifikat.status_laporan_magang = 'Revisi Sedang Diproses'
            db.session.commit()

            from helpers import log_aktivitas
            log_aktivitas(
                actor_id=session['user_id'],
                role_actor='Peserta',
                aktivitas='Upload Revisi Laporan',
                deskripsi='Peserta mengunggah revisi laporan hasil evaluasi HC',
                target_user_id=session['user_id']
            )
            flash('Laporan revisi berhasil diupload.', 'success')
            return redirect(url_for('pemeriksaan_logbook'))
        else:
            flash('File laporan revisi wajib diupload.', 'danger')
            return redirect(request.url)

    return render_template('revisi-laporan.html',
                           peserta=peserta,
                           sertifikat=sertifikat)


@app.route('/sertifikat/presentasi', methods=['GET', 'POST'])
def presentasi_laporan():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))

    user_id = session['user_id']
    peserta = DataPeserta.query.filter_by(id_user=user_id).first()
    status_pendaftaran = StatusPendaftaran.query.filter_by(id_peserta=peserta.id).first() if peserta else None
    sertifikat = SertifikatMagang.query.filter_by(id_user=user_id).first()

    if request.method == 'POST':
        judul_laporan = request.form.get('judul_laporan')
        file = request.files.get('presentasi_magang')

        ALLOWED_EXTENSIONS = {'pdf', 'pptx'}
        MAX_FILE_SIZE = 10 * 1024 * 1024  # 10 MB

        def allowed_file(filename):
            return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

        if not file or not file.filename:
            flash('File presentasi wajib diunggah.', 'danger')
            return redirect(request.url)

        if not allowed_file(file.filename):
            flash('Format file harus PDF atau PPTX.', 'danger')
            return redirect(request.url)

        file.seek(0, 2)
        size = file.tell()
        file.seek(0)
        if size > MAX_FILE_SIZE:
            flash('Ukuran file maksimal 10 MB.', 'danger')
            return redirect(request.url)

        from werkzeug.utils import secure_filename
        filename = secure_filename(file.filename)
        file_path = 'uploads/' + filename
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

        if not sertifikat:
            sertifikat = SertifikatMagang(id_user=user_id)

        sertifikat.judul_laporan_magang = judul_laporan
        sertifikat.presentasi_magang = file_path

        db.session.add(sertifikat)
        db.session.commit()

        flash('Presentasi laporan berhasil dikumpulkan.', 'success')
        return redirect(url_for('presentasi_waiting'))  # Asumsi ada halaman revisi laporan

    return render_template('presentasi-laporan.html', peserta=peserta, status=status_pendaftaran, sertifikat=sertifikat)

@app.route('/sertifikat/presentasi/waiting')
def presentasi_waiting():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))
    return render_template('presentasi-waiting.html')

@app.route('/sertifikat/presentasi/schedule')
def presentasi_schedule():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))

    user_id = session['user_id']
    peserta = DataPeserta.query.filter_by(id_user=user_id).first()
    status_pendaftaran = StatusPendaftaran.query.filter_by(id_peserta=peserta.id).first() if peserta else None
    sertifikat = SertifikatMagang.query.filter_by(id_user=user_id).first()

    if not sertifikat or not status_pendaftaran:
        flash('Data peserta tidak lengkap.', 'danger')
        return redirect(url_for('homepeserta'))

    # Ambil tanggal dan waktu presentasi
    tanggal = sertifikat.tanggal_presentasi
    waktu = sertifikat.waktu_presentasi

    return render_template('presentasi-schedule.html',
                           peserta=peserta,
                           status=status_pendaftaran,
                           sertifikat=sertifikat,
                           tanggal=tanggal,
                           waktu=waktu)

@app.route('/sertifikat')
def sertifikat():
    if 'user_id' not in session or session.get('user_role') != 'Peserta':
        flash('Anda harus login sebagai peserta.', 'warning')
        return redirect(url_for('login'))

    user_id = session['user_id']
    peserta = DataPeserta.query.filter_by(id_user=user_id).first()
    sertifikat = SertifikatMagang.query.filter_by(id_user=user_id).first()

    if not peserta:
        flash('Data peserta tidak ditemukan.', 'danger')
        return redirect(url_for('homepeserta'))

    return render_template('sertifikat.html', peserta=peserta, sertifikat=sertifikat)


# ================ Route untuk Divisi HC ===============================

# Route halaman utama admin
@app.route('/homeadmin')
def homeadmin():
    if 'user_id' not in session or session.get('user_role') not in ['HC Admin', 'PAM Admin']:
        flash('Anda harus login sebagai admin untuk mengakses halaman ini.', 'warning')
        return redirect(url_for('login'))

    try:
        # --- Total Pendaftar ---
        total_pendaftar = db.session.query(LogAktivitas).filter(
            LogAktivitas.aktivitas == 'Pendaftaran Magang'
        ).count()

        # --- Ditolak ---
        total_ditolak = db.session.query(LogAktivitas).filter(
            LogAktivitas.deskripsi.ilike('%Ditolak%')
        ).count()

        # --- Wawancara ---
        wawancara = db.session.query(LogAktivitas).filter(
            LogAktivitas.deskripsi.ilike("%Status Pendaftaran = 'Wawancara'%")
        ).count()

        # --- Proses Seleksi ---
        sub_pendaftar = db.session.query(LogAktivitas.actor_id).filter(
            LogAktivitas.aktivitas == 'Pendaftaran Magang'
        ).subquery()

        proses_seleksi = db.session.query(LogAktivitas.actor_id).filter(
            LogAktivitas.actor_id.in_(sub_pendaftar),
            LogAktivitas.aktivitas == 'Upload Kelengkapan Berkas'
        ).distinct()

        proses_seleksi_ids = set([row.actor_id for row in db.session.query(LogAktivitas.actor_id).filter(
            LogAktivitas.aktivitas == 'Pendaftaran Magang'
        ).all()]) - set([row.actor_id for row in proses_seleksi])

        jumlah_proses_seleksi = len(proses_seleksi_ids)

        # --- Kelengkapan Berkas ---
        kelengkapan = db.session.query(LogAktivitas).filter(
            LogAktivitas.aktivitas == 'Upload Kelengkapan Berkas'
        ).all()

        kelengkapan_ids = [k.actor_id for k in kelengkapan]

        sudah_dijadwal = db.session.query(LogAktivitas.target_user_id).filter(
            LogAktivitas.aktivitas == 'Penjadwalan Wawancara',
            LogAktivitas.target_user_id != None
        ).all()
        sudah_dijadwal_ids = [s.target_user_id for s in sudah_dijadwal]

        kelengkapan_berkas = len(set(kelengkapan_ids) - set(sudah_dijadwal_ids))

        # --- Magang Sedang Berlangsung ---
        selesai_wawancara = db.session.query(LogAktivitas).filter(
            LogAktivitas.aktivitas == 'Wawancara Selesai'
        ).all()
        actor_ids_selesai_wawancara = [x.actor_id for x in selesai_wawancara]

        sudah_upload_sertifikat = db.session.query(LogAktivitas).filter(
            LogAktivitas.aktivitas == 'Upload Sertifikat Magang'
        ).all()
        target_ids_upload_sertifikat = [x.target_user_id for x in sudah_upload_sertifikat]

        sedang_magang = len(set(actor_ids_selesai_wawancara) - set(target_ids_upload_sertifikat))

        # --- Cetak Sertifikat ---
        cetak_sertifikat = db.session.query(LogAktivitas).filter(
            LogAktivitas.aktivitas == 'Upload Laporan Magang'
        ).count()

        return render_template(
            'home-admin.html',
            user_name=session.get('user_name'),
            total_pendaftar=total_pendaftar,
            total_ditolak=total_ditolak,
            wawancara=wawancara,
            proses_seleksi=jumlah_proses_seleksi,
            kelengkapan_berkas=kelengkapan_berkas,
            sedang_magang=sedang_magang,
            cetak_sertifikat=cetak_sertifikat
        )

    except Exception as e:
        flash(f"Terjadi kesalahan saat memuat data: {e}", "danger")
        return redirect(url_for('login'))


@app.route('/datapendaftaran')
def datapendaftaran():
    
    try:
        now = datetime.now()

        # Ambil log aktivitas terakhir dari aktivitas penting
        subquery_log = db.session.query(
            LogAktivitas.target_user_id.label('user_id'),
            func.max(LogAktivitas.timestamp).label('last_activity')
        ).filter(
            LogAktivitas.aktivitas.in_([
                'Pendaftaran Magang',
                'Upload Kelengkapan Berkas',
                'Upload Revisi Kelengkapan Berkas',
                'Penjadwalan Wawancara',
                'Wawancara Selesai'
            ])
        ).group_by(LogAktivitas.target_user_id).subquery()

        # Ambil data peserta dengan join aktivitas terakhir
        result = db.session.query(
            DataPeserta.id,
            DataPeserta.nama,
            User.email,
            DataPeserta.asal_kampus,
            StatusPendaftaran.status_daftar,
            StatusPendaftaran.status_berkas,
            subquery_log.c.last_activity
        ).join(User, DataPeserta.id_user == User.id)\
         .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
         .outerjoin(subquery_log, subquery_log.c.user_id == User.id)\
         .filter(StatusPendaftaran.status_daftar.notin_(['Diterima', 'Ditolak']))\
         .all()

        # Hitung waktu tunggu dan pisahkan data
        data_aktif = []
        data_wawancara = []

        for row in result:
            waktu_tunggu = (now - row.last_activity).days if row.last_activity else None
            row_data = {
                'id': row.id,
                'nama': row.nama,
                'email': row.email,
                'asal_kampus': row.asal_kampus,
                'status_daftar': row.status_daftar,
                'status_berkas': row.status_berkas,
                'last_activity': row.last_activity,
                'waktu_tunggu': waktu_tunggu
            }

            if row.status_daftar == 'Wawancara':
                data_wawancara.append(row_data)
            else:
                data_aktif.append(row_data)

        # Urutkan berdasarkan aktivitas terlama
        data_aktif.sort(key=lambda x: x['last_activity'] or datetime.min)
        data_wawancara.sort(key=lambda x: x['last_activity'] or datetime.min)

        return render_template(
            'data-pendaftaran.html',
            data_aktif=data_aktif,
            data_wawancara=data_wawancara,
            now=datetime.now()
        )

    except Exception as e:
        logger.error(f"Kesalahan pada route 'datapendaftaran': {e}")
        flash(f"Terjadi kesalahan: {e}", "danger")
        return redirect(url_for('homeadmin'))


@app.route('/detaildatapeserta/<int:id>', methods=['GET', 'POST'])
def detaildatapeserta(id):
    peserta = db.session.query(DataPeserta, StatusPendaftaran, BerkasPeserta)\
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
        .join(BerkasPeserta, DataPeserta.id == BerkasPeserta.id_peserta)\
        .filter(DataPeserta.id == id).first()

    if request.method == 'POST':
        try:
            status_berkas = request.form.get('status-berkas')
            nama_divisi = request.form.get('nama_divisi')
            status_pendaftaran = request.form.get('status-pendaftaran')
            nama_pembimbing_lapangan = request.form.get('nama_pembimbing_lapangan')

            logger.debug(f"Form data diterima: status_berkas={status_berkas}, nama_divisi={nama_divisi}, status_pendaftaran={status_pendaftaran}")

            # Update StatusPendaftaran
            # Jika status berkas adalah "Sesuai", ubah menjadi "Sedang Diproses" sebelum disimpan
            if status_berkas == 'Sesuai':
                peserta.StatusPendaftaran.status_berkas = 'Menunggu Peserta'
            else:
                peserta.StatusPendaftaran.status_berkas = status_berkas
           
            peserta.StatusPendaftaran.status_daftar = status_pendaftaran

            if status_pendaftaran == 'Kel. Berkas':
                peserta.StatusPendaftaran.nama_divisi = nama_divisi
                peserta.DataPeserta.nama_pembimbing_lapangan = nama_pembimbing_lapangan

            # Menghandle file upload
            file_tanda_pengenal = request.files.get('surat_tanda_pengenal')
            if file_tanda_pengenal and file_tanda_pengenal.filename:
                file_path_tanda_pengenal = save_file(file_tanda_pengenal)
                peserta.BerkasPeserta.surat_pembuatan_idcard = file_path_tanda_pengenal
                logger.debug(f"File surat tanda pengenal berhasil disimpan: {file_path_tanda_pengenal}")

            file_penerimaan = request.files.get('surat_penerimaan')
            if file_penerimaan and file_penerimaan.filename:
                file_path_penerimaan = save_file(file_penerimaan)
                peserta.BerkasPeserta.surat_penerimaan = file_path_penerimaan
                logger.debug(f"File surat penerimaan berhasil disimpan: {file_path_penerimaan}")

            else:
                # Null-kan jika status berkas bukan "Sesuai"
                peserta.StatusPendaftaran.nama_divisi = None
                peserta.BerkasPeserta.surat_pembuatan_idcard = None
                peserta.BerkasPeserta.surat_penerimaan = None        
            
            db.session.commit()

            from helpers import log_aktivitas
            log_aktivitas(
                actor_id=session.get('user_id'),
                role_actor=session.get('user_role'),
                aktivitas='Update Status Administrasi Pendaftaran',
                deskripsi=f"HC memperbarui status peserta {peserta.DataPeserta.nama} (ID {id}) menjadi: {status_pendaftaran} | Status Berkas: {status_berkas}",
                target_user_id=peserta.DataPeserta.id_user
            )

            flash('Status berhasil diperbarui.', 'success')
            logger.debug("Status pendaftaran berhasil diperbarui.")
            return redirect(url_for('datapendaftaran'))

        except Exception as e:
            db.session.rollback()
            logger.error(f"Terjadi kesalahan saat memperbarui status: {e}")
            flash(f"Terjadi kesalahan: {e}", 'danger')
    return render_template('detail-datapeserta.html', peserta=peserta)


@app.route('/detaildatapesertakelberkas/<int:id>', methods=['GET', 'POST'])
def detaildatapesertakelberkas(id):
    peserta = db.session.query(DataPeserta, StatusPendaftaran, BerkasPeserta, User)\
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
        .join(BerkasPeserta, DataPeserta.id == BerkasPeserta.id_peserta)\
        .join(User, DataPeserta.id_user == User.id)\
        .filter(DataPeserta.id == id).first()
    
    data_peserta, status_pendaftaran, berkas_peserta, user = peserta
    peserta = {
        "DataPeserta": data_peserta,
        "StatusPendaftaran": status_pendaftaran,
        "BerkasPeserta": berkas_peserta,
        "User": user
    }

    if request.method == 'POST':
        try:
            status_pendaftaran = request.form.get('status-pendaftaran')
            catatan = request.form.get('catatan')
            revisi_list = request.form.getlist('revisi_berkas[]')  # Ambil daftar revisi dari checkbox
            # status_berkas = 'Revisi' if len(revisi_list) > 0 else 'Sedang Diproses'
            status_berkas = request.form.get('status_berkas')
            logger.debug(f"Form data diterima: status_berkas={status_berkas}, status_pendaftaran={status_pendaftaran}, catatan={catatan}, revisi={revisi_list}")

            # Kondisi khusus: jika berkas sesuai & peserta lanjut wawancara
            if status_berkas == 'Sesuai' and status_pendaftaran == 'Wawancara':
                peserta["StatusPendaftaran"].status_berkas = 'Menentukan Tanggal'
            else:
                peserta["StatusPendaftaran"].status_berkas = status_berkas
            peserta["StatusPendaftaran"].status_daftar = status_pendaftaran

            # Simpan catatan jika status berkas adalah Revisi
            if status_berkas == 'Revisi':
                peserta["StatusPendaftaran"].catatan = catatan
                peserta["StatusPendaftaran"].set_revisi_berkas(revisi_list)
            else:
                peserta["StatusPendaftaran"].catatan = None
                peserta["StatusPendaftaran"].revisi_berkas = json.dumps([])

            db.session.commit()

            from helpers import log_aktivitas
            log_aktivitas(
                actor_id=session.get('user_id'),
                role_actor=session.get('user_role'),
                aktivitas='Update Status Kelengkapan Berkas Peserta',
                deskripsi=(
                    f"HC meninjau kelengkapan berkas milik peserta {peserta['DataPeserta'].nama} (ID {id}) "
                    f"dengan hasil: Status Pendaftaran = '{status_pendaftaran}', Status Berkas = '{status_berkas}'"
                ),
                target_user_id=peserta["User"].id
            )

            flash('Status berhasil diperbarui.', 'success')
            logger.debug("Status pendaftaran berhasil diperbarui.")
            return redirect(url_for('datapendaftaran'))

        except Exception as e:
            db.session.rollback()
            logger.error(f"Terjadi kesalahan saat memperbarui status: {e}")
            flash(f"Terjadi kesalahan saat memperbarui data: {e}", 'danger')

    return render_template('detail-datapeserta-kelberkas.html', peserta=peserta)

@app.route('/sertifikatadmin')
def sertifikat_admin():
    try:
        now = datetime.now()

        # Subquery: ambil aktivitas terakhir terkait laporan
        subquery_log = db.session.query(
            LogAktivitas.target_user_id.label('user_id'),
            func.max(LogAktivitas.timestamp).label('last_activity')
        ).filter(
            LogAktivitas.aktivitas.in_([
                'Review Laporan Akhir',
                'Upload Sertifikat Magang',
                'Upload Revisi Laporan'
            ])
        ).group_by(LogAktivitas.target_user_id).subquery()

        data_raw = db.session.query(
            DataPeserta.id,
            DataPeserta.nama,
            User.id.label('user_id'),
            User.email,
            DataPeserta.asal_kampus,
            StatusPendaftaran.nama_divisi,
            SertifikatMagang.status_laporan_magang,
            subquery_log.c.last_activity
        ).join(User, DataPeserta.id_user == User.id)\
         .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
         .outerjoin(SertifikatMagang, SertifikatMagang.id_user == DataPeserta.id_user)\
         .outerjoin(subquery_log, subquery_log.c.user_id == User.id)\
         .filter(StatusPendaftaran.status_daftar == 'Diterima')\
         .all()

        data_peserta = []
        for row in data_raw:
            waktu_tunggu = (now - row.last_activity).days if row.last_activity else None
            data_peserta.append({
                'id': row.id,
                'nama': row.nama,
                'email': row.email,
                'asal_kampus': row.asal_kampus,
                'nama_divisi': row.nama_divisi,
                'status_laporan_magang': row.status_laporan_magang,
                'last_activity': row.last_activity,
                'waktu_tunggu': waktu_tunggu
            })

        # Urutkan dari yang terlama tidak aktif
        data_peserta.sort(key=lambda x: x['last_activity'] or datetime.min)

        return render_template('sertifikat-admin.html', data_peserta=data_peserta)
    except Exception as e:
        logger.error(f"Kesalahan pada route 'sertifikatadmin': {e}")
        flash(f"Terjadi kesalahan: {e}", "danger")
        return redirect(url_for('homeadmin'))


@app.route('/review-laporanakhir/<int:id>', methods=['GET', 'POST'])
def review_laporanakhir(id):
    peserta_tuple = db.session.query(DataPeserta, StatusPendaftaran, BerkasPeserta, User)\
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
        .join(BerkasPeserta, DataPeserta.id == BerkasPeserta.id_peserta)\
        .join(User, DataPeserta.id_user == User.id)\
        .filter(DataPeserta.id == id).first()
    
    if not peserta_tuple:
        flash('Peserta tidak ditemukan.', 'danger')
        return redirect(url_for('sertifikat_admin'))

    data_peserta, status_pendaftaran, berkas_peserta, user = peserta_tuple
    sertifikat = SertifikatMagang.query.filter_by(id_user=user.id).first()
    logbooks = Logbook.query.filter_by(id_peserta=data_peserta.id).order_by(Logbook.tanggal_logbook).all()


    # Pastikan objek sertifikat ada
    if not sertifikat:
        sertifikat = SertifikatMagang(id_user=user.id)
        db.session.add(sertifikat)
        db.session.commit()

    peserta = {
        "DataPeserta": data_peserta,
        "StatusPendaftaran": status_pendaftaran,
        "BerkasPeserta": berkas_peserta,
        "User": user
    }

    if request.method == 'POST':
        status_laporan = request.form.get('status_laporan')
        catatan_revisi = request.form.get('catatan_revisi')
        file_revisi = request.files.get('laporan_revisi_hc')

        sertifikat.status_laporan_magang = status_laporan
        sertifikat.catatan_revisi_laporan = catatan_revisi

        if file_revisi and file_revisi.filename:
            filename = secure_filename(file_revisi.filename)
            file_path = os.path.join('uploads', filename)
            file_revisi.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            sertifikat.laporan_revisi_hc = file_path

        # Logic: jika status sesuai, ubah ke "Tentukan Tanggal Presentasi"
        if status_laporan == 'Sesuai':
            sertifikat.status_laporan_magang = 'Tentukan Tanggal Presentasi'

        db.session.commit()
        # Logging sesuai status
        from helpers import log_aktivitas
        if status_laporan == 'Sesuai':
            log_aktivitas(
                actor_id=session.get('user_id'),
                role_actor=session.get('user_role'),
                aktivitas='Review Laporan Magang – Diterima',
                deskripsi=f"HC menyatakan laporan peserta {peserta['DataPeserta'].nama} (ID {id}) SUDAH SESUAI dan melanjutkan ke tahap presentasi.",
                target_user_id=peserta["User"].id
            )
        elif status_laporan == 'Revisi Laporan':
            log_aktivitas(
                actor_id=session.get('user_id'),
                role_actor=session.get('user_role'),
                aktivitas='Review Laporan Magang – Revisi',
                deskripsi=f"HC meminta revisi laporan peserta {peserta['DataPeserta'].nama} (ID {id}).",
                target_user_id=peserta["User"].id
            )
        flash('Review laporan berhasil disimpan.', 'success')
        return redirect(url_for('sertifikat_admin'))

    return render_template('review-laporanakhir.html', peserta=peserta, sertifikat=sertifikat, logbooks=logbooks)

@app.route('/logbook/modal/<int:id_peserta>')
def logbook_modal(id_peserta):
    logbooks = Logbook.query.filter_by(id_peserta=id_peserta).order_by(Logbook.tanggal_logbook).all()
    return render_template('logbook_modal_content.html', logbooks=logbooks)

@app.route('/review-sertifikat/<int:id>', methods=['GET', 'POST'])
def review_sertifikat(id):
    peserta_tuple = db.session.query(DataPeserta, StatusPendaftaran, BerkasPeserta, User)\
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
        .join(BerkasPeserta, DataPeserta.id == BerkasPeserta.id_peserta)\
        .join(User, DataPeserta.id_user == User.id)\
        .filter(DataPeserta.id == id).first()

    if not peserta_tuple:
        flash('Peserta tidak ditemukan.', 'danger')
        return redirect(url_for('sertifikat_admin'))

    data_peserta, status_pendaftaran, berkas_peserta, user = peserta_tuple
    sertifikat = SertifikatMagang.query.filter_by(id_user=user.id).first()
    logbooks = Logbook.query.filter_by(id_peserta=data_peserta.id).order_by(Logbook.tanggal_logbook).all()

    peserta = {
        "DataPeserta": data_peserta,
        "StatusPendaftaran": status_pendaftaran,
        "BerkasPeserta": berkas_peserta,
        "User": user
    }

    if request.method == 'POST':
        file_sertifikat = request.files.get('sertifikat_magang')
        if file_sertifikat and file_sertifikat.filename:
            filename = secure_filename(file_sertifikat.filename)
            file_path = os.path.join('uploads', filename)
            file_sertifikat.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            sertifikat.sertifikat_magang = 'uploads/' + filename
            sertifikat.status_laporan_magang = 'Sertifikat Tercetak'
            db.session.commit()

            from helpers import log_aktivitas
            log_aktivitas(
                actor_id=session['user_id'],
                role_actor='HC Admin',
                aktivitas='Upload Sertifikat Magang',
                deskripsi=f'HC mengunggah sertifikat magang untuk peserta ID {id}',
                target_user_id=peserta["User"].id
            )

            flash('Sertifikat berhasil diupload.', 'success')
            return redirect(url_for('sertifikat_admin'))
        else:
            flash('File sertifikat wajib diupload.', 'danger')

    return render_template('review-sertifikat.html', peserta=peserta, sertifikat=sertifikat, logbooks=logbooks)


def generate_dummy_dates():
    # 1. Tanggal Daftar: antara 2018 dan 2025
    tanggal_daftar = datetime(
        year=random.randint(2018, 2025),
        month=random.randint(1, 12),
        day=random.randint(1, 28)
    )
    # 2. Tanggal Magang Dimulai: antara 1–2 bulan setelah daftar
    tanggal_mulai = tanggal_daftar + timedelta(days=random.randint(30, 60))
    # 3. Tanggal Magang Selesai: antara 1–6 bulan setelah mulai
    tanggal_selesai = tanggal_mulai + timedelta(days=random.randint(30, 180))

    return tanggal_daftar, tanggal_mulai, tanggal_selesai

@app.route('/datapesertaprakerin')
def datapesertaprakerin():
    try:
        # Ambil data peserta dengan status daftar = 'Diterima' dan join status laporan
        data_peserta = (
            db.session.query(
                DataPeserta.id,
                DataPeserta.nama,
                User.email,
                DataPeserta.asal_kampus,
                StatusPendaftaran.nama_divisi,
                SertifikatMagang.status_laporan_magang,
                DataPeserta.tanggal_dimulai,
                DataPeserta.tanggal_berakhir,
            )
            .join(User, DataPeserta.id_user == User.id)
            .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)
            .outerjoin(SertifikatMagang, SertifikatMagang.id_user == DataPeserta.id_user)
            .filter(
                and_(
                    StatusPendaftaran.status_daftar == 'Diterima',
                    or_(
                        SertifikatMagang.status_laporan_magang.is_(None),
                        SertifikatMagang.status_laporan_magang != 'Sertifikat Tercetak'
                    )
                )
            )
            .all()
        )
        data_peserta_with_dates = []
        for row in data_peserta:
            t_daftar, t_mulai, t_selesai = generate_dummy_dates()
            data_peserta_with_dates.append({
                'data': row,
                'tanggal_daftar': t_daftar,
                'tanggal_mulai': t_mulai,
                'tanggal_selesai': t_selesai
            })

        # Peserta ditolak atau sudah selesai magang
        data_arsip = (
            db.session.query(
                DataPeserta.id,
                DataPeserta.nama,
                User.email,
                DataPeserta.asal_kampus,
                StatusPendaftaran.nama_divisi,
                SertifikatMagang.status_laporan_magang,
                StatusPendaftaran.status_daftar
            )
            .join(User, DataPeserta.id_user == User.id)
            .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)
            .outerjoin(SertifikatMagang, SertifikatMagang.id_user == DataPeserta.id_user)
            .filter(
                or_(
                    StatusPendaftaran.status_daftar == 'Ditolak',
                    SertifikatMagang.status_laporan_magang == 'Sertifikat Tercetak'
                )
            )
            .all()
        )
        data_arsip_with_dates = []
        for row in data_arsip:
            t_daftar, t_mulai, t_selesai = generate_dummy_dates()
            data_arsip_with_dates.append({
                'data': row,
                'tanggal_daftar': t_daftar,
                'tanggal_mulai': t_mulai,
                'tanggal_selesai': t_selesai
            })


        return render_template('datapesertaprakerin.html', data_peserta=data_peserta_with_dates, data_arsip=data_arsip_with_dates)
    except Exception as e:
        logger.error(f"Kesalahan pada route 'datapesertaprakerin': {e}")
        flash(f"Terjadi kesalahan: {e}", "danger")
        return redirect(url_for('homeadmin'))


@app.route('/generate_report', methods=['POST'])
def generate_report():
    try:
        # Mengambil filter dari form
        tanggal_mulai = request.form.get('tanggal_mulai')
        tanggal_selesai = request.form.get('tanggal_selesai')
        asal_kampus = request.form.get('asal_kampus')
        nama_divisi = request.form.get('nama_divisi')

        # Debug log filter yang diterima
        print(f"Filter diterima - Tanggal Mulai: {tanggal_mulai}, Tanggal Selesai: {tanggal_selesai}, "
              f"Asal Kampus: {asal_kampus}, Nama Divisi: {nama_divisi}")

        # Query data peserta berdasarkan filter
        query = db.session.query(
            DataPeserta.nama,
            DataPeserta.asal_kampus,
            DataPeserta.tanggal_dimulai,
            DataPeserta.tanggal_berakhir,
            StatusPendaftaran.nama_divisi
        ).join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)

        if tanggal_mulai and tanggal_selesai:
            query = query.filter(
                DataPeserta.tanggal_dimulai >= datetime.strptime(tanggal_mulai, '%Y-%m-%d'),
                DataPeserta.tanggal_berakhir <= datetime.strptime(tanggal_selesai, '%Y-%m-%d')
            )
        if asal_kampus:
            query = query.filter(DataPeserta.asal_kampus.ilike(f"%{asal_kampus}%"))
        if nama_divisi:
            query = query.filter(StatusPendaftaran.nama_divisi.ilike(f"%{nama_divisi}%"))

        data_peserta = query.all()
        print(f"Jumlah data peserta yang ditemukan: {len(data_peserta)}")

        if not data_peserta:
            flash('Tidak ada data yang sesuai dengan filter.', 'warning')
            return redirect(url_for('datapesertaprakerin'))
        
        # Membuat dokumen PDF menggunakan FPDF
        pdf = FPDF()
        pdf.add_page()
        pdf.set_auto_page_break(auto=True, margin=15)

        # Menambahkan margin halaman
        pdf.set_left_margin(10)
        pdf.set_right_margin(15)
        
        # Menambahkan logo
        pdf.image('static/images/logopindad.png', 10, 8, 33)
        pdf.set_font('Arial', 'B', 16)
        pdf.cell(0, 10, 'PT PINDAD', ln=True, align='C')
        pdf.cell(0, 10, 'Laporan Data Peserta Prakerin', ln=True, align='C')
        pdf.ln(10)

        # Menambahkan header tabel
        pdf.set_font('Times', 'B', 10)
        column_widths = [10, 40, 50, 25, 25, 40]  # Lebar kolom yang disesuaikan
        headers = ['No', 'Nama', 'Asal Kampus', 'Tanggal Dimulai', 'Tanggal Berakhir', 'Divisi']

        # Menulis header tabel
        for i, header in enumerate(headers):
            pdf.cell(column_widths[i], 10, header, 1, 0, 'C')
        pdf.ln()        

        # Menambahkan data peserta ke tabel
        pdf.set_font('Times', '', 10)
        for i, peserta in enumerate(data_peserta, 1):
            pdf.cell(column_widths[0], 10, str(i), 1, 0, 'C')
            pdf.cell(column_widths[1], 10, peserta.nama, 1, 0, 'L')
            pdf.cell(column_widths[2], 10, peserta.asal_kampus, 1, 0, 'L')
            pdf.cell(column_widths[3], 10, peserta.tanggal_dimulai.strftime('%d/%m/%Y'), 1, 0, 'C')
            pdf.cell(column_widths[4], 10, peserta.tanggal_berakhir.strftime('%d/%m/%Y'), 1, 0, 'C')
            pdf.cell(column_widths[5], 10, peserta.nama_divisi, 1, 1, 'L')

        # Menambahkan tanggal dan waktu pembuatan di bawah halaman
        pdf.ln(10)
        pdf.set_font('Times', 'I', 9)
        timestamp = datetime.now().strftime('%d/%m/%Y %H:%M:%S')
        user_name = session.get('user_name', 'Unknown User')
        pdf.cell(0, 10, f'Dibuat pada: {timestamp} oleh {user_name}', 0, 0, 'R')
       
        # Menyimpan file ke buffer
        output = BytesIO()
        output.write(pdf.output(dest='S').encode('latin1'))
        output.seek(0)

        # Mengirimkan file ke pengguna
        return send_file(output, as_attachment=True, download_name='Laporan_Peserta_Prakerin.pdf', mimetype='application/pdf')

    except Exception as e:
        import traceback
        print("Error saat membuat laporan:")
        print(traceback.format_exc())        
        flash(f"Terjadi kesalahan saat membuat laporan: {str(e)}", 'danger')
        return redirect(url_for('datapesertaprakerin'))


@app.route('/detailpesertaprakerin/<int:id>')
def detailpesertaprakerin(id):
    peserta_tuple = db.session.query(DataPeserta, StatusPendaftaran, BerkasPeserta, User)\
        .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)\
        .join(BerkasPeserta, DataPeserta.id == BerkasPeserta.id_peserta)\
        .join(User, DataPeserta.id_user == User.id)\
        .filter(DataPeserta.id == id).first()
    
    if not peserta_tuple:
        flash('Peserta tidak ditemukan.', 'danger')
        return redirect(url_for('datapesertaprakerin'))

    data_peserta, status_pendaftaran, berkas_peserta, user = peserta_tuple
    sertifikat = SertifikatMagang.query.filter_by(id_user=user.id).first()
    logbooks = Logbook.query.filter_by(id_peserta=data_peserta.id).order_by(Logbook.tanggal_logbook).all()

    peserta = {
        "DataPeserta": data_peserta,
        "StatusPendaftaran": status_pendaftaran,
        "BerkasPeserta": berkas_peserta,
        "User": user
    }

    return render_template(
        'detailpesertaprakerin.html',
        peserta=peserta,
        sertifikat=sertifikat,
        logbooks=logbooks
    )


# ================ Route untuk Divisi PAM ===============================

@app.route('/datawawancara', methods=['GET', 'POST'])
def datawawancara():
    try:
        # Peserta yang perlu ditentukan tanggal wawancara
        peserta_menentukan_tanggal = (
            db.session.query(
                DataPeserta.id,
                DataPeserta.nama,
                User.email,
                DataPeserta.asal_kampus,
                DataPeserta.tanggal_dimulai,
                DataPeserta.tanggal_berakhir,
                StatusPendaftaran.tanggal_wawancara,
                StatusPendaftaran.status_berkas,
                StatusPendaftaran.status_daftar,
                StatusPendaftaran.nama_divisi
            )
            .join(User, DataPeserta.id_user == User.id)
            .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)
            .filter(StatusPendaftaran.status_berkas == 'Menentukan Tanggal')
            .all()
        )

        # Peserta dengan tanggal sudah ditentukan
        peserta_tanggal_sudah_ditetapkan = (
            db.session.query(
                DataPeserta.id,
                DataPeserta.nama,
                User.email,
                DataPeserta.asal_kampus,
                DataPeserta.tanggal_dimulai,
                DataPeserta.tanggal_berakhir,
                StatusPendaftaran.tanggal_wawancara,
                StatusPendaftaran.status_berkas,
                StatusPendaftaran.status_daftar,
                StatusPendaftaran.nama_divisi
            )
            .join(User, DataPeserta.id_user == User.id)
            .join(StatusPendaftaran, DataPeserta.id == StatusPendaftaran.id_peserta)
            .filter(StatusPendaftaran.status_berkas == 'Tanggal Sudah Ditentukan')
            .all()
        )

        if request.method == 'POST':
            action_type = request.form.get('action_type')
            peserta_id = request.form.get('peserta_id')
            status_pendaftaran = StatusPendaftaran.query.filter_by(id_peserta=peserta_id).first()

            if action_type == 'set_date' and status_pendaftaran:
                tanggal_wawancara = request.form.get('tanggal_wawancara')
                waktu_wawancara = request.form.get('waktu_wawancara')
                datetime_wawancara = datetime.strptime(f"{tanggal_wawancara} {waktu_wawancara}", '%Y-%m-%d %H:%M')
                # ✅ Cek apakah sudah ada 3 peserta pada waktu ini
                jumlah_pada_waktu_ini = StatusPendaftaran.query.filter(
                    StatusPendaftaran.tanggal_wawancara == datetime_wawancara
                ).count()

                if jumlah_pada_waktu_ini >= 3:
                    flash('Sudah ada 3 peserta yang dijadwalkan pada waktu tersebut. Silakan pilih waktu lain.', 'danger')
                    return redirect(url_for('datawawancara'))
                
                status_pendaftaran.tanggal_wawancara = datetime.strptime(f"{tanggal_wawancara} {waktu_wawancara}", '%Y-%m-%d %H:%M')
                status_pendaftaran.status_berkas = 'Tanggal Sudah Ditentukan'
                db.session.commit()

                from helpers import log_aktivitas
                log_aktivitas(
                    actor_id=session.get('user_id'),
                    role_actor=session.get('user_role'),
                    aktivitas='Penjadwalan Wawancara',
                    deskripsi=f'PAM menetapkan tanggal wawancara untuk peserta ID {peserta_id}',
                    target_user_id=status_pendaftaran.id_peserta
                )

                flash('Tanggal wawancara berhasil ditentukan!', 'success')
                return redirect(url_for('datawawancara'))

            elif action_type == 'selesai' and status_pendaftaran:
                status_pendaftaran.status_daftar = 'Diterima'
                status_pendaftaran.status_berkas = 'Sesuai'
                    # Ambil nama PIC dari form
                pic_name = request.form.get('pic_wawancara')
                peserta_data = DataPeserta.query.filter_by(id=peserta_id).first()
                if peserta_data:
                    peserta_data.pic_wawancara = pic_name
                db.session.commit()

                from helpers import log_aktivitas
                log_aktivitas(
                    actor_id=session.get('user_id'),
                    role_actor=session.get('user_role'),
                    aktivitas='Wawancara Selesai',
                    deskripsi=f'PAM menyelesaikan proses wawancara peserta ID {peserta_id}',
                    target_user_id=status_pendaftaran.id_peserta
                )

                flash('Status peserta diubah menjadi selesai wawancara.', 'success')
                return redirect(url_for('datawawancara'))

            elif action_type == 'batal' and status_pendaftaran:
                status_pendaftaran.status_berkas = 'Menentukan Tanggal'
                status_pendaftaran.tanggal_wawancara = None
                db.session.commit()

                from helpers import log_aktivitas
                log_aktivitas(
                    actor_id=session.get('user_id'),
                    role_actor=session.get('user_role'),
                    aktivitas='Pembatalan Jadwal Wawancara',
                    deskripsi=f'PAM membatalkan jadwal wawancara peserta ID {peserta_id}',
                    target_user_id=status_pendaftaran.id_peserta
                )
                flash('Jadwal wawancara dibatalkan.', 'warning')
                return redirect(url_for('datawawancara'))

        return render_template(
            'datapeserta-wawancara.html',
            peserta_menentukan_tanggal=peserta_menentukan_tanggal,
            peserta_tanggal_sudah_ditetapkan=peserta_tanggal_sudah_ditetapkan,
        )
    except Exception as e:
        flash(f'Terjadi kesalahan: {e}', 'danger')
        return redirect(url_for('homeadmin'))


@app.route('/selesaikanwawancara/<int:id>', methods=['POST'])
def selesaikanwawancara(id):
    try:
        peserta = StatusPendaftaran.query.filter_by(id_peserta=id).first()
        peserta.status_daftar = 'Diterima'
        db.session.commit()
        from helpers import log_aktivitas
        log_aktivitas(
            actor_id=session.get('user_id'),
            role_actor=session.get('user_role'),
            aktivitas='Wawancara Selesai via AJAX',
            deskripsi=f'PAM menyelesaikan wawancara peserta ID {id} melalui endpoint AJAX',
            target_user_id=id
        )
        return jsonify({'success': True})
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'error': str(e)})

@app.route('/datapresentasi', methods=['GET', 'POST'])
def datapresentasi():
    try:
        # --- Tabel Atas: Peserta yang butuh ditentukan tanggal presentasi
        peserta_tentukan_tanggal = (
            db.session.query(
                DataPeserta.id,
                DataPeserta.nama,
                User.email,
                DataPeserta.asal_kampus,
                DataPeserta.tanggal_dimulai,
                DataPeserta.tanggal_berakhir,
                SertifikatMagang.tanggal_presentasi,
                SertifikatMagang.status_laporan_magang,
                SertifikatMagang.presentasi_magang,
                StatusPendaftaran.nama_divisi,
            )
            .join(User, DataPeserta.id_user == User.id)
            .join(SertifikatMagang, SertifikatMagang.id_user == User.id)
            .join(StatusPendaftaran, StatusPendaftaran.id_peserta == DataPeserta.id)
            .filter(SertifikatMagang.status_laporan_magang == 'Tentukan Tanggal Presentasi')
            .all()
        )

        # --- Tabel Bawah: Peserta yang sudah punya tanggal dan status 'Presentasi'
        peserta_status_presentasi = (
            db.session.query(
                DataPeserta.id,
                DataPeserta.nama,
                User.email,
                DataPeserta.asal_kampus,
                DataPeserta.tanggal_dimulai,
                DataPeserta.tanggal_berakhir,
                SertifikatMagang.tanggal_presentasi,
                SertifikatMagang.waktu_presentasi,
                SertifikatMagang.status_laporan_magang,
                SertifikatMagang.presentasi_magang,
                StatusPendaftaran.nama_divisi,
            )
            .join(User, DataPeserta.id_user == User.id)
            .join(SertifikatMagang, SertifikatMagang.id_user == User.id)
            .join(StatusPendaftaran, StatusPendaftaran.id_peserta == DataPeserta.id)
            .filter(SertifikatMagang.status_laporan_magang == 'Presentasi')
            .all()
        )

        if request.method == 'POST':
            # Penentuan tanggal presentasi dari form atas
            action_type = request.form.get('action_type')
            peserta_id = request.form.get('peserta_id')
            sertifikat = None

            if peserta_id:
                peserta_row = DataPeserta.query.get(int(peserta_id))
                sertifikat = SertifikatMagang.query.filter_by(id_user=peserta_row.id_user).first()

            if action_type == 'set_date' and sertifikat:
                tanggal_presentasi = request.form.get('tanggal_presentasi')
                waktu_presentasi = request.form.get('waktu_presentasi')
                datetime_presentasi = datetime.strptime(f"{tanggal_presentasi} {waktu_presentasi}", '%Y-%m-%d %H:%M')
                # ✅ Validasi maksimal 3 peserta per waktu
                peserta_di_jam_ini = SertifikatMagang.query.filter(
                    and_(
                        SertifikatMagang.tanggal_presentasi == datetime_presentasi.date(),
                        SertifikatMagang.waktu_presentasi == datetime_presentasi.strftime('%H:%M')
                    )
                ).count()

                if peserta_di_jam_ini >= 3:
                    flash('Sudah ada 3 peserta yang dijadwalkan presentasi pada jam tersebut. Pilih jam lain.', 'danger')
                    return redirect(url_for('datapresentasi'))

                file_presentasi = request.files.get('presentasi_magang')

                # Simpan file PPT jika diupload
                if file_presentasi and file_presentasi.filename:
                    from werkzeug.utils import secure_filename
                    filename = secure_filename(file_presentasi.filename)
                    file_path = os.path.join('uploads', filename)
                    file_presentasi.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                    sertifikat.presentasi_magang = 'uploads/' + filename

                sertifikat.tanggal_presentasi = datetime.strptime(tanggal_presentasi, '%Y-%m-%d').date()
                sertifikat.waktu_presentasi = waktu_presentasi
                sertifikat.status_laporan_magang = 'Presentasi'
                db.session.commit()

                from helpers import log_aktivitas
                log_aktivitas(
                    actor_id=session.get('user_id'),
                    role_actor=session.get('user_role'),
                    aktivitas='Penjadwalan Presentasi',
                    deskripsi=f'PAM menjadwalkan presentasi peserta ID {peserta_id}',
                    target_user_id=sertifikat.id_user
                )
                flash('Tanggal presentasi berhasil ditentukan!', 'success')
                return redirect(url_for('datapresentasi'))

            elif action_type == 'selesai' and sertifikat:
                pic_presentasi = request.form.get('pic_presentasi')
                sertifikat.status_laporan_magang = 'Menunggu Sertifikat'
                sertifikat.pic_presentasi = pic_presentasi
                db.session.commit()
                from helpers import log_aktivitas
                log_aktivitas(
                    actor_id=session.get('user_id'),
                    role_actor=session.get('user_role'),
                    aktivitas='Presentasi Selesai',
                    deskripsi=f'PAM menyelesaikan presentasi peserta ID {peserta_id}',
                    target_user_id=sertifikat.id_user
                )

                flash('Status presentasi peserta diubah menjadi selesai.', 'success')
                return redirect(url_for('datapresentasi'))

            elif action_type == 'batal' and sertifikat:
                sertifikat.status_laporan_magang = 'Tentukan Tanggal Presentasi'
                sertifikat.tanggal_presentasi = None
                sertifikat.waktu_presentasi = None
                db.session.commit()
                from helpers import log_aktivitas
                log_aktivitas(
                    actor_id=session.get('user_id'),
                    role_actor=session.get('user_role'),
                    aktivitas='Jadwal Presentasi Dibatalkan',
                    deskripsi=f'PAM membatalkan jadwal presentasi peserta ID {peserta_id}',
                    target_user_id=sertifikat.id_user
                )
                flash('Status presentasi peserta diubah kembali untuk penjadwalan ulang.', 'warning')
                return redirect(url_for('datapresentasi'))

        return render_template(
            'datapresentasi.html',
            peserta_tentukan_tanggal=peserta_tentukan_tanggal,
            peserta_status_presentasi=peserta_status_presentasi,
        )
    except Exception as e:
        flash(f'Terjadi kesalahan: {e}', 'danger')
        return redirect(url_for('homeadmin'))


# Route halaman logout
@app.route('/logout')
def logout():
    session.clear()
    flash('Anda telah logout.', 'info')
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True, port=5002)
