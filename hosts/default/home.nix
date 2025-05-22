{ config, pkgs, ... }:


{
	  # Home Manager needs a bit of information about you and the paths it should
	  # manage.
	  home.username = "muller";
	  home.homeDirectory = "/home/muller";
	  home.keyboard = {
		layout = "us";
		options = ["ctrl:nocaps"];
	  };
	home.sessionVariables = {
	    EDITOR = "nvim";
	    GOPATH = "${config.home.homeDirectory}/go";
	    GOBIN = "$GOPATH/bin";
	  };

	  # This value determines the Home Manager release that your configuration is
	  # compatible with. This helps avoid breakage when a new Home Manager release
	  # introduces backwards incompatible changes.
	  #
	  # You should not change this value, even if you update Home Manager. If you do
	  # want to update the value, then make sure to first check the Home Manager
	  # release notes.
	  home.stateVersion = "24.11"; # Please read the comment before changing.

	  # The home.packages option allows you to install Nix packages into your
	  home.packages = with pkgs; [
		#Core Tools
		go
		gopls

		#Dev
		just
		tmux
		lazygit
		fzf
		unzip
		wget
		curl
		zlib

		#Rust
		rustup

		#cpp
		llvmPackages_latest.clang
		llvmPackages_latest.clang-tools
		llvmPackages_latest.libcxx
		llvmPackages_latest.lld

		# Python
		python3

		# PostgresTools
		postgresql_15

		#nvin and lsp support
		lua-language-server
		nodePackages.typescript-language-server
		nodePackages.vscode-langservers-extracted
		jdt-language-server

		# Shell and terminal
		
		# GUI apps
		discord
		anki-bin
		act
		vscode
		obsidian
		postman
		firefox
		libreoffice-qt6-fresh
		spotify
		blender
        gimp-with-plugins
	  ];	

	  # Home Manager is pretty good at managing dotfiles. The primary way to manage
	  # plain files is through 'home.file'.

	    
	  # Let Home Manager install and manage itself.
	  programs.home-manager.enable = true;
}
