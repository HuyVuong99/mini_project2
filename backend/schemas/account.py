from .base_schemas import SchemasBase


class Account(SchemasBase):
    username: str
    password: str
    email: str
    role: str
    score: float
    id: str

