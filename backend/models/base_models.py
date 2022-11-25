from config_db import db
from peewee import Model


class BaseModel_db(Model):

    class Meta:
        database = db
