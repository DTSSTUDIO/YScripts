cls
@ECHO OFF
IF EXIST "utils/downloaded.dat" (
    IF EXIST "utils/installed.dat" (
        IF EXIST "utils/module.dat" (
            echo "Setup complated, just runing the application"
            start "" InstagramBot.jar
        ) ELSE (
            "%userprofile%\AppData\Local\Programs\Python\Python37\python.exe" -m pip install --upgrade pip

            "%userprofile%\AppData\Local\Programs\Python\Python37\Scripts\pip.exe" install instapy

            echo "%userprofile%\AppData\Local\Programs\Python\Python37\python.exe" > instalib\info.dat

            cd utils
            echo "Java 8u211 & Python 3.7.3" > module.dat
            
            cd ..
            Instabot.bat
        )
    ) ELSE (
        cd utils
        start /w jre-8u211-windows-i586.exe /s INSTALLDIR=%userprofile%\AppData\Local\Programs\java\jre1.8.2

        python-3.7.3.exe InstallAllUsers=0 Include_launcher=0 Include_test=0 SimpleInstall=1 SimpleInstallDescription="Just for Instobot"

        echo "Java 8u211 & Python 3.7.3" > installed.dat
                
        cd ..
        Instabot.bat
    )
) ELSE (
    cd utils
    (wget.exe -O "python-3.7.3.exe" "https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe" && wget.exe -O "jre-8u211-windows-i586.exe" "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=238727_478a62b7d4e34b78b671c754eaaf38ab") || echo "Error while installation" && pause && exit

    REM del /s / q .wget-hsts
    REM del /s /q python-3.7.3.exe
    REM del /s /q jre-8u211-windows-i586.exe
    
    echo "Java 8u211 & Python 3.7.3" > downloaded.dat
    
    cd ..
    Instabot.bat
)

