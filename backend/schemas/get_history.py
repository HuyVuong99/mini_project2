from .base_schemas import SchemasBase


class History_Bets(SchemasBase):
    email: str


class Match_number(SchemasBase):
    match_number: int
    result: str
