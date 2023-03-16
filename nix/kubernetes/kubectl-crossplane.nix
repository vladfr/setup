{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
    name = "kubectl-crossplane";
    version = "v1.11.2";
    channel = "stable";
    _bin = "crank";
    src = fetchurl {
        url = "https://releases.crossplane.io/${channel}/${version}/bin/darwin_amd64/${_bin}";
        sha256 = "Tx3hXBRASjYLgt6DIqiPRLxa+OOFQ1kfrZgRXQr6+tI=";
        pname = "kubectl-crossplane";
        inherit version;
        executable = true;
    };

    unpackPhase = ''
        ls -al ./
    '';

    installPhase = ''
        mkdir -p $out/bin/
        ln -s $src $out/bin/kubectl-crossplane
    '';

    meta = with lib; {
        homepage = "https://crossplane.io";
        description = "Crossplane CLI plugin for kubectl";
    };

}