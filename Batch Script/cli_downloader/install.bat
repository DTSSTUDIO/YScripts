mkdir downloads

cd utils
wget -i ../inputs.txt -P ../downloads

cd ../downloads

@echo off
setlocal EnableDelayedExpansion
set i=0
for %%a in (*) do (
    set /a i+=1
    ren "%%a" "!i!.new"
)
ren *.new *.jpg
