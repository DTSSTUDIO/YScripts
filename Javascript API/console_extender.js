(function (console) {
    console.download = (data, filename, mime) => {
        if (!data) {
            console.error("Veri olmadan indirme işlemi yapılmaz")
            return;
        }

        if (!data.includes("http")) {
            if (typeof data === "object") {
                mime = "text/json"
                data = JSON.stringify(data)
            }
            data = `data:${mime};charset=utf-8,${encodeURIComponent(data)}`

            if (!filename) {
                filename = `template.${(mime && mime.includes('/')) ? mime.split('/')[0] : "txt"}`
            }
        }

        if (!mime) mime = 'text/plain'
        if (!filename) filename = data.split('/').pop()

        const link = document.createElement("a");

        link.download = filename;
        link.href = data
        link.style.display = 'none';

        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

        delete link;
    }

    console.sleep = milliseconds => {
        const start = new Date().getTime();
        for (var i = 0; i < 1e7; i++) {
            if ((new Date().getTime() - start) > milliseconds) {
                break;
            }
        }
    }


    console.bulkDownload = (datas, filenames, mimes) => {

        function checkParam(param) {
            return typeof param === "object"
        }

        if (!datas) {
            console.error("Veri olamadan indirme işlemi yapılamaz")
            return
        }

        if (![datas, filenames, mimes].every(checkParam)) console.warn("Her bir parametre, dizi ya da liste türünde olmalı")

        for (let i = 0; i < datas.length; i++) {
            data = datas[i]
            try {
                filename = filenames[i]
                mime = mimes[i]
            } catch (e) {
                filename = false
                mime = false
            } finally {
                console.download(data, filename, mime)
                console.sleep(100) // Bekleme olmazsa chrome her dosyayı indirmiyor
            }

        }
    }

    console.startAndWait = async (method, ms, param) => {
        const result = param ? method(param) : method()
        await new Promise((r, j) => setTimeout(r, ms));
        return result
    }

    console.startDelayed = async (method, ms, param) => {
        await new Promise((r, j) => setTimeout(r, ms));
        return param ? method(param) : method()
    }

})(console)
