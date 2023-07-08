{ pkgs, lib, config, ... }:
{
	programs.zsh = {
		enable = true;
		dotDir = ".config/zsh";
		# initExtraFirst = "zmodload zsh/zprof";
		initExtraBeforeCompInit = ''
			zstyle ':completion:*' menu select
			zmodload -i zsh/complist
			'';
		completionInit = ''
			autoload -Uz compinit

			() {
				if [[ $# -gt 0 ]]; then
						echo compinit -i
						compinit -i
				else
						compinit -C -i
						fi
			} ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24)
		'';
		initExtra = ''
		source ${./config/zsh-conf.zsh}
		source ${./config/p10k.zsh}
		source ${./lib/history.zsh}
		source ${./lib/completion.zsh}
		source ${./lib/key-bindings.zsh}
		source ${./lib/git.zsh}
		'';
		plugins = [
		{/*{{{*/
			name = "zsh-autosuggestions";
			src = pkgs.fetchFromGitHub {
				owner = "zsh-users";
				repo = "zsh-autosuggestions";
				rev = "v0.7.0";
				sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
			};
		}/*}}}*/
		{/*{{{*/
			name = "fast-syntax-highlighting";
			src = pkgs.fetchFromGitHub {
				owner = "zdharma-continuum";
				repo = "fast-syntax-highlighting";
				rev = "v1.55";
				sha256 = "sha256-DWVFBoICroKaKgByLmDEo4O+xo6eA8YO792g8t8R7kA=";
			};
		}/*}}}*/
		{/*{{{*/
			name = "powerlevel10k";
			file = "powerlevel10k.zsh-theme";
			src = pkgs.fetchFromGitHub {
				owner = "romkatv";
				repo = "powerlevel10k";
				rev = "v1.17.0";
				sha256 = "sha256-fgrwbWj6CcPoZ6GbCZ47HRUg8ZSJWOsa7aipEqYuE0Q=";
			};
		}/*}}}*/
		];
		# zplug = {
		# 	enable = true;
		# 	zplugHome = "${config.xdg.dataHome}/zplug";
		# 	plugins = [
		# 	{ name = "lib/key-bindings";   tags = [from:oh-my-zsh]; }
		# 	{ name = "plugins/git";   tags = [from:oh-my-zsh]; }
		# 	];
		# };
	};
}
