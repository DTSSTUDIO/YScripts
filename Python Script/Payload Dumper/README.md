# Payload Dumper

`payload.bin` adlı dosyalardan `*.image` dosyaları oluşturur.

> Telefonların ROM'ları bu şekilde saklanır.

### System requirement

- Python3, pip
- google protobuf for python `pip install protobuf`

### Guide

- Make you sure you have Python 3.6 installed.
- Download payload_dumper.py and update_metadata_pb2.py here.
- Extract your OTA zip and place payload.bin in the same folder as these files.
- Open PowerShell, Command Prompt, or Terminal depending on your OS.
- Enter the following command: python -m pip install protobuf
- When that’s finished, enter this command: python payload_dumper.py payload.bin
- This will start to extract the images within the payload.bin file to the current folder you are in.

<!--Index-->

## 📂 Harici Dosyalar

- [payload_dumper.py](./payload_dumper.py)
- [requirements.txt](./requirements.txt)
- [update_metadata_pb2.py](./update_metadata_pb2.py)

<!--Index-->
