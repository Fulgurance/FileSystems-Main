class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        configureSource(arguments:  "--prefix=/usr      \
                                    --sysconfdir=/etc   \
                                    --enable-elf-shlibs \
                                    --disable-libblkid  \
                                    --disable-libuuid   \
                                    --disable-uuidd     \
                                    --disable-fsck",
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

        runGunzipCommand(   arguments:  "libext2fs.info.gz",
                            path:       "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/info/")

        deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/libcom_err.a")
        deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/libe2p.a")
        deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/libext2fs.a")
        deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/libss.a")
    end

    def install
        super

        runInstallInfoCommand(arguments:    "--dir-file=/usr/share/info/dir \
                                            /usr/share/info/libext2fs.info")
    end

end
