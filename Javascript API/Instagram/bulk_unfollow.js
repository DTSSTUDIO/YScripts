
const DELAY = 500

async function test(count) {
	const buttons = getFollowButtons()
	for (let i = 0; i < count + 1; i++) {
		const button = buttons[i]
		button.click()
		await startDelayed(clickUnfollow, DELAY)
	}
}

async function unfollowAll() {
	const buttons = getFollowButtons()
	for (let i = 0; i < buttons.length; i++) {
		const button = buttons[i]
		button.click()
		await startDelayed(clickUnfollow, DELAY)
	}
}

async function startDelayed(method, ms) {
	await new Promise((r, j) => setTimeout(r, ms));
	return method();
}

function getFollowButtons() {
	const buttons = document.getElementsByTagName("button")
	const followButtons = []
	for (let i = 0; i < buttons.length; i++) {
		const button = buttons[i]
		if (button.innerText == "Following") {
			followButtons.push(button)
		}
	}
	return followButtons
}

function clickUnfollow() {
	document.getElementsByClassName("-Cab_")[0].click()
}