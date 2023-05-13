# CommandBox

## Setup

Download CommandBox from https://www.ortussolutions.com/products/commandbox

> If running CommandBox on a server, install it to a central location that all sites will reference.

For example, if running Windows, create C:\CommandBox and place the `box.exe` and `jre` directory there.

Next, create a `CommandBoxFiles` directory in there and then create a `commandbox.properties` file with the following:

```bash
commandbox_home=C:\\CommandBox\\CommandBoxFiles
```

This will be the directory where all the CommandBox files will be stored.

Finally, add `C:\CommandBox` to your path so that anytime you call `box` from a command line, it will start CommandBox using that executable.

## Additional Modules:

Paste this into CommandBox to install the essential modules.

```bash
http https://raw.githubusercontent.com/garciadev/itb-2023-workshop-api/main/essentials.boxr | recipe
```

This is a recipe that will install several useful modules as well as setup some handy aliases. You can read more about recipes and more in the <a href="https://commandbox.ortusbooks.com/" target="_blank">CommandBox Documentation</a> site.


[Back](../readMe.md)
