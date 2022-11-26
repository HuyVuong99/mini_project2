from .base_schemas import SchemasBase


class Sign_in(SchemasBase):
    email: str
    password: str
