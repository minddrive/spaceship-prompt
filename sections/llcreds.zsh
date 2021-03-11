#
# LindenLab's "aws_creds" notification
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_LLCREDS_SHOW="${SPACESHIP_LLCREDS_SHOW=true}"
SPACESHIP_LLCREDS_PREFIX="${SPACESHIP_LLCREDS_PREFIX="("}"
SPACESHIP_LLCREDS_SUFFIX="${SPACESHIP_LLCREDS_SUFFIX=")"}"
SPACESHIP_LLCREDS_COLOR_FULL="${SPACESHIP_LLCREDS_COLOR_FULL="green"}"
SPACESHIP_LLCREDS_COLOR_HALF="${SPACESHIP_LLCREDS_COLOR_HALF="yellow"}"
SPACESHIP_LLCREDS_COLOR_LOW="${SPACESHIP_LLCREDS_COLOR_LOW="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_llcreds() {
  [[ $SPACESHIP_LLCREDS_SHOW == false ]] && return

  if [[ -n "${AWS_ACCOUNT}" ]]; then
    local datecmd

    if [[ "$(uname -s)" == "Darwin" ]]; then
       datecmd="gdate"
    else
       datecmd="date"
    fi

    local llcreds_color
    local time_left=$(( $(${datecmd} +%s --date="${AWS_EXPIRATION}") - $(date +%s) ))
    
    # Determination of what color should be used
    if [[ "${time_left}" -gt 1800 ]]; then
      llcreds_color=$SPACESHIP_LLCREDS_COLOR_FULL
    elif [[ "${time_left}" -gt 900 ]]; then
      llcreds_color=$SPACESHIP_LLCREDS_COLOR_HALF
    elif [[ "${time_left}" -gt 0 ]]; then
      llcreds_color=$SPACESHIP_LLCREDS_COLOR_LOW
    fi
  
    spaceship::section \
      "$llcreds_color" \
      "$SPACESHIP_LLCREDS_PREFIX" \
      "${AWS_ACCOUNT_SHORT}" \
      "$SPACESHIP_LLCREDS_SUFFIX"
  fi
}
