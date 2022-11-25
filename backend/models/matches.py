from .base_models import BaseModel_db
from peewee import CharField,IntegerField


class Matches(BaseModel_db):
    match_number = IntegerField()
    round_number = IntegerField()
    date_time = CharField()
    location_match = CharField()
    home_team = CharField()
    away_team = CharField()
    group_match = CharField()
    result = CharField()
    goal = CharField()

    class Meta:
        db_table = 'match'

    @classmethod
    def get_list(cls):
        query = cls.select().dicts()
        return list(query)


