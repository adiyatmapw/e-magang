from app import db
from models import LogAktivitas
from datetime import datetime

def log_aktivitas(actor_id, role_actor, aktivitas, deskripsi=None, target_user_id=None):
    try:
        log = LogAktivitas(
            actor_id=actor_id,
            role_actor=role_actor,
            aktivitas=aktivitas,
            deskripsi=deskripsi,
            target_user_id=target_user_id,
            timestamp=datetime.now()
        )
        db.session.add(log)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        print(f"[LogAktivitas Error] Gagal mencatat log aktivitas: {e}")
