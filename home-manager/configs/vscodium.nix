{ config, pkgs, ...}:
let 
	ext =  name: publisher: version: sha256: pkgs.vscode-utils.buildVscodeMarketplaceExtension {
	mktplcRef = { inherit name publisher version sha256 ; };
	};
in
{
	programs.vscode = {
		package=pkgs.vscodium;
		enable=true;
		userSettings  = {
			"files.autoSave" = "afterDelay";
			"files.autoSaveDelay" = 0;
			"window.zoomLevel"= -1;
			"files.exclude" = ""; # stop excluding files please
			"workbench.colorTheme"= "Tomorrow Night Blue";
			"editor.multiCursorModifier" = "ctrlCmd"; # ctrl + click for multi cursor
			"terminal.integrated.fontFamily" = "DroidSansM Nerd Font"; # fc-list to see all fonts
		};
		keybindings =  [
			{
				key = "ctrl+f8";
				command = "editor.action.marker.next";
			}
			{
				key="ctrl+shift+[";
				command= "workbench.debug.action.focusRepl";
			}
			{
				key="ctrl+shift+]";
				command= "workbench.action.termPinal.focus";
			}
			{
				key = "alt+d";
				command = "editor.action.deleteLines";
			}
			{
				key = "ctrl+shift+1";
				command = "workbench.action.terminal.resizePaneUp";
				when = "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
			}
			{
				key = "ctrl+shift+2";
				command = "workbench.action.terminal.resizePaneDown";
				when = "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
			}
			{
				key = "ctrl+alt+m";
				command = "markdown.showLockedPreviewToSide";
			}
		];
		mutableExtensionsDir = false; # stops vscode from editing ~/.vscode/extensions/* which makes the following extensions actually install
		# installing malware

		extensions = (with pkgs.vscode-extensions; [
			ms-python.vscode-pylance
			ms-vscode-remote.remote-containers
			ms-azuretools.vscode-docker
			batisteo.vscode-django
			ms-python.python
			shd101wyy.markdown-preview-enhanced
			ms-toolsai.jupyter
			
		]) ++ [
			(ext "Nix" "bbenoist" "1.0.1" "sha256-qwxqOGublQeVP2qrLF94ndX/Be9oZOn+ZMCFX1yyoH0=") # https://marketplace.visualstudio.com/items?itemName=bbenoist.Nix
			(ext "copilot" "GitHub"  "1.188.867" "sha256-s5Y+INK/YpunMnbKlXP7YeE115lqj24te/QpWMBktV4=") # https://marketplace.visualstudio.com/items?itemName=GitHub.copilot
			(ext  "bash-debug" "rogalmic" "0.3.9" "sha256-f8FUZCvz/PonqQP9RCNbyQLZPnN5Oce0Eezm/hD19Fg=") # https://marketplace.visualstudio.com/items?itemName=rogalmic.bash-debug
			(ext "nix-ide" "jnoortheen" "0.3.1" "sha256-jwOM+6LnHyCkvhOTVSTUZvgx77jAg6hFCCpBqY8AxIg=" ) # https://marketplace.visualstudio.com/items?itemName=jnoortheen.nix-ide
		];
	}; # END VSCODE
}