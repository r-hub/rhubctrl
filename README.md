
# rhubctrl

> Manage an Instance of 'r-hub'

[![Linux Build Status](https://travis-ci.org//rhubctrl.svg?branch=master)](https://travis-ci.org//rhubctrl)

[![Windows Build status](https://ci.appveyor.com/api/projects/status/github//rhubctrl?svg=true)](https://ci.appveyor.com/project//rhubctrl)
[![](http://www.r-pkg.org/badges/version/rhubctrl)](http://www.r-pkg.org/pkg/rhubctrl)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/rhubctrl)](http://www.r-pkg.org/pkg/rhubctrl)


Deploy and manage an installation of r-hub, a CI environment for R packages.

## Installation

```r
devtools::install_github("/rhubctrl")
```

## Usage

```r
library(rhubctrl)
```

## Internals

### Configuration

All virtual machines and containers are configured via environment
variables. Sensitive information is store encrypted in this repository
using the `secure` R package (https://github.com/hadley/secure). The
process of passing on this information to the virtual machines and
containers is as follows:
1. The package decprypt the configuration information using
   `secure::decrypt`.
2. It sets up environment variables based on this, in a temporary shell,
   to start the virtual machines via Vagrant.
3. Vagrant picks up these environment variables, and sets them in the
   virtual machine.
4. The script that starts a Docker container and/or manages Dokku,
   transfers the needed environment variables into the container(s).

## License

MIT + file LICENSE © 
