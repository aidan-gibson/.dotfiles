#!/bin/zsh
# <xbar.title>Nightscout</xbar.title>
# <xbar.version>0.0.1</xbar.version>
# <xbar.desc>Dexcom CGM blood sugar data from Nightscout</xbar.desc>
# <xbar.dependencies>zsh, curl, jq</xbar.dependencies>
# <xbar.author>Aidan Gibson</xbar.author>
# <xbar.author.github>aidan-gibson</xbar.author.github>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>
#<swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>
if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed.'
  echo '---'
  echo 'Click here to install jq | href=https://stedolan.github.io/jq/download/'
  exit 1
fi

# <xbar.image>https://raw.githubusercontent.com/jhaydraude/NightscoutBitBar/master/Preview.png</xbar.image>
# <xbar.abouturl>https://github.com/jhaydraude/NightscoutBitBar/blob/master/README.md</xbar.abouturl>

NSURL=https://nightscoutaidangibson.herokuapp.com
# curl --silent https://nightscoutaidangibson.herokuapp.com/api/v1/entries.json returns a bunch
# curl --silent https://nightscoutaidangibson.herokuapp.com/api/v1/entries/current.json returns latest
JSONOUT=$(curl --silent $NSURL/api/v1/entries/current.json)
BG=$(jq '.[0].sgv' <<< "$JSONOUT")
TRENDSTR=$(jq -r '.[0].direction' <<< "$JSONOUT")
JSDATEMS=$(jq '.[0].date' <<< "$JSONOUT") # ms since epoch from ns, ie 1688680830707.2092
JSDATES=$((JSDATEMS/1000)) # s since epoch from ns, ie 1688680830.7072091
CURR_SECONDS=$(date +%s)
TIMEDIFF_S=CURR_SECONDS-JSDATES
TIMEDIFF=$(( TIMEDIFF_S / 60 ))
TIMEDIFF=${TIMEDIFF:0:1} #truncates, keeps only first digit
# date +%s is current time in seconds 
# on linux u can date +%s%3N, but doesn't work on macOS
case $TRENDSTR in
	FortyFiveUp)
		TREND='↗'
		;;
	FortyFiveDown)
		TREND='↘'
		;;
	SingleUp)
		TREND='↑'
		;;
	SingleDown)
		TREND='↓'
		;;
	Flat)
		TREND='→'
		;;
	DoubleUp)
		TREND='⇈'
		;;
	DoubleDown)
		TREND='⇊'
		;;
	*)
		TREND=$TRENDSTR
		;;
esac
echo $BG $TREND "(${TIMEDIFF}m)"

# curl --silent https://nightscoutaidangibson.herokuapp.com/api/v1/entries.json | jq -r '.[0].sgv' # returns current bg

# save entire json THEN parse it instead of re-fetching each time bc don't want values not 

# also want trend and how long ago