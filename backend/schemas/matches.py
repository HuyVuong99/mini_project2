from .base_schemas import SchemasBase


class Match(SchemasBase):
    match_number: int
    round_number: int
    date_time: str
    location_match: str
    home_team: str
    away_team: str
    group_match: str
    result: str
    goal: str
