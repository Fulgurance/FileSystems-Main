class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--prefix=/usr      \
                                    --bindir=/usr/sbin  \
                                    --sysconfdir=/etc   \
                                    --enable-manpages   \
                                    --disable-static",
                        path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        if option("Openrc")
            prepareOpenrcServiceInstallation(   path:   "#{workDirectoryPath}/Udev-Postmount-Init.d",
                                                name:   "udev-postmount")
        end
    end

    def install
        super

        runUdevadmCommand("hwdb --update")
    end

    def deploy
        if autoDeployServices
            if option("Openrc")
                runRcUpdateCommand("add udev sysinit")
                runRcUpdateCommand("add udev-trigger sysinit")
            end
        end
    end

end
