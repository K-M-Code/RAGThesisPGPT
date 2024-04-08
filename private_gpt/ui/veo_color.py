class Color:
    all = []

    def __init__(
        self,
        c50: str,
        c100: str,
        c200: str,
        c300: str,
        c400: str,
        c500: str,
        c600: str,
        c700: str,
        c800: str,
        c900: str,
        c950: str,
        name: str | None = None,
    ):
        self.c50 = c50
        self.c100 = c100
        self.c200 = c200
        self.c300 = c300
        self.c400 = c400
        self.c500 = c500
        self.c600 = c600
        self.c700 = c700
        self.c800 = c800
        self.c900 = c900
        self.c950 = c950
        self.name = name
        Color.all.append(self)

    def expand(self) -> list[str]:
        return [
            self.c50,
            self.c100,
            self.c200,
            self.c300,
            self.c400,
            self.c500,
            self.c600,
            self.c700,
            self.c800,
            self.c900,
            self.c950,
        ]

sky = Color(
    name="sky",
    c50="#f0f9ff",
    c100="#e0f2fe",
    c200="#bae6fd",
    c300="#7dd3fc",
    c400="#38bdf8",
    c500="#0ea5e9",
    c600="#0284c7",
    c700="#0369a1",
    c800="#075985",
    c900="#0c4a6e",
    c950="#0b4165",
)
blue = Color(
    name="blue",
    c50="#eff6ff",
    c100="#dbeafe",
    c200="#bfdbfe",
    c300="#93c5fd",
    c400="#60a5fa",
    c500="#3b82f6",
    c600="#2563eb",
    c700="#1d4ed8",
    c800="#1e40af",
    c900="#1e3a8a",
    c950="#1d3660",
)

veo_primary = Color(
    name="sky",
    c50="#f0f9ff",
    c100="#BED600",
    c200="#bae6fd",
    c300="#7dd3fc",
    c400="#38bdf8",
    c500="#0075B0",
    c600="#0284c7",
    c700="#0369a1",
    c800="#075985",
    c900="#0c4a6e",
    c950="#0b4165",
)