{
  buildNpmPackage,
  src,
  version,
  pkg-config,
  python3,
  vips,
}:

buildNpmPackage {
  pname = "opengym-frontend";
  inherit version src;

  sourceRoot = "${src.name}/frontend";
  npmDepsHash = "sha256-Kc4Jccd5JQPCqiomqCZjkDc88p0VnCU1xxjDnEOK9rQ=";

  makeCacheWritable = true;

  nativeBuildInputs = [
    pkg-config
    python3
  ];
  buildInputs = [ vips ];

  buildPhase = ''
    npm run build
  '';

  # The upstream `catalogue/media/` exercise media is intentionally NOT bundled: it is not
  # AGPL and redistribution is restricted, so it cannot live in the nixpkgs store path.
  # Operators who need it supply a copy via services.opengym.mediaRoot (see the NixOS module).
  installPhase = ''
    runHook preInstall

    cp -R dist/* $out/

    runHook postInstall
  '';
}
