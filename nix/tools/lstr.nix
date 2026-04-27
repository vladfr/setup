{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "lstr";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "bgreenwell";
    repo = "lstr";
    rev = "main";
    sha256 = "sha256-Bg2tJYnXpJQasmcRv+ZIZAVteKUCuTgFKVRHw1CCiAQ=";
  };

  cargoHash = "sha256-KlO/Uz9UPea4DFC6U4hvn4kOWSzUmYmckw+IUstcmeQ=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  doCheck = false;

  meta = with lib; {
    description = "A fast, minimalist directory tree viewer, written in Rust";
    homepage = "https://github.com/bgreenwell/lstr";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "lstr";
  };
}
