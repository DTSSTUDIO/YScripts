/**
 * MHRS'den otomatik randevu alma veya sorgulama
 * https://www.hastanerandevu.gov.tr/Randevu/login.xhtml;jsessionid=c5oxj5m50al6gyncgzvoeZyK
 * TODO Butonlar 1'den 10'a kadar 10 dahil
 */

const TC_NUMBER = ""
const PASSWORD = ""

async function test() {
	try {
		await clearSelections()
		await startDateSelection(3)
		await selectDoctor([0, 14, 19, 1, 0, 0, 0])
		// selectDoctor(["istanbul", "büyükçekmece", "kulak burun boğaz hastalıkları", "i̇stanbul- (avrupa)- beyli̇kdüzü devlet hastanesi̇ (beyli̇kdüzü devlet hastanesi̇)", "-farketmez-", "emi̇r pervi̇z mi̇rzaoğlu"])
		await searchWithSelections()
		console.log(parseDoctorInfos())
	} catch (exception) {
		console.log("Hata: " + exception)
	}
}

function makeAppointment() {
	// TODO testi buraya aktar
	try {
		var username = TC_NUMBER
		var password = PASSWORD
		login(username, password)
		// sayfa yüklenene kadar bekle
	} catch (exception) {
		console.log("Hata: " + exception)
	}
}

async function startDateSelection(offset) {

	function toggleDatePicker() {
		document.getElementsByTagName("button")[1].click()
	}

	function getAllButtons() {
		return document.querySelectorAll("tr a.ui-state-default")
	}

	function selectDate() {
		if (offset > 0) {
			// Seçim ekranını açma
			toggleDatePicker()

			// 1 gün sonrası 0. index olur (offset - 1)
			dateButtons = getAllButtons()
			if ((offset - 1) < dateButtons.length) {
				dateButtons[offset - 1].click()
			} else {
				// Seçim ekranını kapatma
				toggleDatePicker()
				throw "Verilen tarihe randevu alınamaz"
			}
		} else {
			throw "Offset 0'dan küçük olamaz"
		}
	}

	await startAndWait(selectDate, 1000)

	// document.getElementById("tarihKurumHekim_input").value = getDateTR(offset)
}

async function selectDoctor(infos) {
	// TODO province, district, clinic, hospital, examination, doctor yapısına bir bak
	// TODO Ezbere bilmeyenler için şehirleri listeleyebilirsin.
	// TODO direkt olarak doktor isminden seçebilirsin
	// TODO Seleniumda halledebilirsin bunu, filter input gelene kadar bekletirsin, gelince toggle edersin

	function getFilterInputs() {
		return document.getElementById("randevuFiltrePanel").querySelectorAll("input.ui-autocomplete-input.ui-autocomplete-dd-input.ui-inputfield.ui-widget.ui-state-default.ui-corner-left.labeledInput[aria-disabled='false']")
	}

	async function toggleSelectionMenu(index) {

		async function clickMenuButton(index) {
			filterInputs = getFilterInputs()
			if (index < filterInputs.length) {
				getFilterInputs()[index].click()
				return true
			} else {
				return false
			}
		}

		await startAndWait(clickMenuButton, 1000, index)
	}

	function getSelectionDatas() {
		return document.getElementsByClassName("ui-autocomplete-item ui-autocomplete-row ui-widget-content ui-corner-all")
	}

	function listSelectionDatas() {
		selectionDatas = getSelectionDatas()
		for (let i = 0; i < selectionDatas.length; i++) {
			console.log(`${i}. ${selectionDatas[i].innerText.toLowerCase()}`)
		}
	}

	async function startDataSelection(index) {

		function clickData(index) {
			selectionDatas = getSelectionDatas()
			if (0 <= index && index < selectionDatas.length) {
				selectionDatas[index].click()
			}
		}

		await startAndWait(clickData, 1000, index)
	}

	for (let i = 0; i < infos.length; i++) {
		await toggleSelectionMenu(i)
		// listSelectionDatas()
		await startDataSelection(infos[i])
	}
}

async function startAndWait(method, ms, param) {
	const result = typeof param != "undefined" ? method(param) : method()
	await new Promise((r, j) => setTimeout(r, ms));
	return result
}

async function clearSelections() {

	function clickClearButton() {
		document.getElementById("clearButton").click()
	}

	await startAndWait(clickClearButton, 2000)
}

async function searchWithSelections() {

	function clickMakeAppointment() {
		document.getElementById("searchButton").click()
	}

	await startAndWait(clickMakeAppointment, 1000)

}

/**
 * Bugüne kıyasla yeni bir gün verisi döndürür
 * @param {number} offset Sonrası ya da öncesi (`-1` 1 gün önce)
 */
function getDateTR(offset = 0) {
	// Günlerin türkçe karşılığı
	day = [
		"Pazar",
		"Pazartesi",
		"Salı",
		"Çarşamba",
		"Perşembe",
		"Cuma",
		"Cumartesi"
	]

	// Değişken tarih oluşturma
	date = new Date()
	date.setDate(date.getDate() + offset)
	dateString = date.toLocaleDateString("tr")
	dayName = day[date.getDay()]

	return dateString + " " + dayName
}

function login(username, password) {
	document.getElementById("username").value = username
	document.getElementById("password").value = password
	document.getElementById("loginButton").click()
}

function parseDoctorInfos() {

	function getDoctorTable() {
		return document.querySelectorAll("tbody#kurumHekimTable_data tr td")
	}

	const doctorTable = getDoctorTable()
	const doctors = []
	for (let i = 0; i < doctorTable.length; i += 6) {
		doctorName = doctorTable[i].innerText
		date = doctorTable[i + 1].innerText
		hospitalName = doctorTable[i + 2].innerText
		clinicName = doctorTable[i + 3].innerText
		exeminationPlace = doctorTable[i + 4].innerText
		ageCondition = doctorTable[i + 5].innerText
		doctors.push({
			name: doctorName,
			date: date,
			hospital: hospitalName,
			clinic: clinicName,
			place: exeminationPlace,
			age: ageCondition
		})
	}
	return doctors
}
