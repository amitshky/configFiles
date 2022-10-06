# color codes:
# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
# 	$([char]0x1b)[0m => Reset
#
# 	8bit color:
# 		$([char]0x1b)[38;5;<color_code>m => foreground
# 		$([char]0x1b)[48;5;<color_code>m => background
#
# 	24bit color:
# 		$([char]0x1b)[38;2;<r>;<g>:<b>m => foreground
# 		$([char]0x1b)[48;2;<r>;<g>:<b>m => background

# format directory as ~/path/to/folder/ = $(([string]$pwd).replace($home, '~').replace('\', '/'))

function global:prompt
{
	$len = 40 # maximum length of the path before you begin truncating
	$path = $executionContext.SessionState.Path.CurrentLocation.path
	$host.ui.RawUI.WindowTitle = $path # display in the title bar

	# ANSI codes
	$fg = "$([char]0x1b)[38;2"   # foreground
	$bg = "$([char]0x1b)[48;2"   # background
	$reset  = "$([char]0x1b)[0m" # resets the colors

	# colors (in RGB format; the m at the end is ANSI code format which are to be concatenated with $fg and/or $bg)
	# usage: $fg;$red
	$red       = "196;101;92m"
	$green     = "184;197;113m"
	$blue      = "132;162;196m"
	$gray      = "45;45;45m"
	$black     = "0;0;0m"
	$lightGray = "120;120;120m"

	$gitBranch = git rev-parse --abbrev-ref HEAD
	$isAdmin   = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

	# ref: https://jdhitsolutions.com/blog/powershell/7149/friday-fun-taking-a-shortcut-path-in-your-powershell-prompt/
	if ($path.length -gt $len) 
	{
		#escape the separator character to treat it as a literal
		#filter out any blank entries which might happen if the path ends with the delimiter
		$split = $path -split "\\" | Where-Object { $_ -match "\S+" }
		#reconstruct a shorted path
		$path = "…\$($split[-3])\$($split[-2])\$($split[-1])"
	}

	# ref: https://www.commandline.ninja/customize-pscmdprompt/
	# Calculate execution time of last cmd and convert to milliseconds, seconds or minutes
	$lastCommand = Get-History -Count 1
	if ($lastCommand) { $runTime = ($lastCommand.EndExecutionTime - $lastCommand.StartExecutionTime).TotalSeconds }

	if ($runTime -ge 60) 
	{
		$ts = [timespan]::fromseconds($runTime)
		$min, $sec = ($ts.ToString("mm\:ss")).Split(":")
		$elapsedtime = "$($min)m $($sec)s"
	}
	else 
	{
		$elapsedtime = [math]::Round(($runTime), 2)
		$elapsedtime = "$($elapsedtime)s"
	}

	# prompt display format
	$start     = "$fg;$lightGray┌─"
	$admin     = "$bg;$red $(if ($isAdmin){ "$fg;$black  Admin " })$bg;$gray$fg;$red"
	$directory = "$bg;$gray$fg;$blue  $path $fg;$gray$bg;$green"
	$gitBranch = "$fg;$black$bg;$green$(if ($gitBranch) { "  $gitBranch " })$reset$fg;$green"
	$end       = "`n$fg;$lightGray└─[$fg;$green$elapsedTime$fg;$lightGray]$reset"

	#Write-Host "" # for initial newline
	Write-Host $start -NoNewline # so that python virtualenv prefix doesn't break the customized prompt  
	return "$admin$directory$gitBranch$end "
}
