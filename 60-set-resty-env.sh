resty_config="/usr/local/openresty/nginx/conf.d/00-openresty.conf"

[ ! -f $resty_config ] || return

if [ $RESTY_SESSION_SECRET != "00000000000000000000000000000000" ];then
    # check for "resty_session_secret" already set
    if (! grep -q "^set resty_session_secret" );then
        echo "set resty_session_secret ${RESTY_SESSION_SECRET}" >> $resty_config
    fi
else
    echo "WARNING: session secret for resty-session not set!" >&2
    echo "Sessions cannot be shared between pods without a consistent session secret." >&2
    echo "resty-session will generate a random session secret for single-pod operation." >&2
fi