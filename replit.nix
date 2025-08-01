{ pkgs }: {
	deps = [
   pkgs.flex
		pkgs.clang
		pkgs.ccls
		pkgs.gdb
		pkgs.gnumake
	];
}