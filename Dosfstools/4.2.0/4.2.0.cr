class Target < ISM::Software

    def configure
        super
        configureSource(arguments:  "--prefix=/usr              \
                                    --enable-compat-symlinks    \
                                    --mandir=/usr/share/man     \
                                    --docdir=/usr/share/doc/dosfstools-4.2",
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
    end

end
