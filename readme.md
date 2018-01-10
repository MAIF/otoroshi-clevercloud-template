# Otoroshi CleverCloud template

This repo holds the build of Otoroshi for CleverCloud

Otoroshi sources are located at https://github.com/MAIF/otoroshi

Don't forget to add a prebuild hook on the CleverCloud app to trigger the build script

```
CC_PRE_BUILD_HOOK=./clevercloud/build.sh
```

If you want to customize the build script, edit `./clevercloud/build.sh`

If you want to customize the configuration file, edit `./clevercloud/prod.conf` or [use env. variables](https://maif.github.io/otoroshi/manual/firstrun/env.html)
