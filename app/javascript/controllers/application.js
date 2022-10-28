import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

const setup = () => {
  function getSidebarStateFromLocalStorage() {
    // if it already there, use it
    if (window.localStorage.getItem('isSidebarOpen')) {
      return JSON.parse(window.localStorage.getItem('isSidebarOpen'))
    }

    // else return the initial state you want
    return (
      false
    )
  }

  function setSidebarStateToLocalStorage(value) {
    window.localStorage.setItem('isSidebarOpen', value)
  }

  return {
    loading: true,
    isSidebarOpen: getSidebarStateFromLocalStorage(),
    toggleSidbarMenu() {
      this.isSidebarOpen = !this.isSidebarOpen
      setSidebarStateToLocalStorage(this.isSidebarOpen)
    },
    isSettingsPanelOpen: false,
    isSearchBoxOpen: false,
  }
}
