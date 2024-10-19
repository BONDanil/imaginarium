import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-selector"
export default class extends Controller {
  static targets = ["image", "input", "submitBtn"]
  static values = {
    selectedClass: String
  }

  connect() {
    if (!this.selectedClassValue) {
      this.selectedClassValue = "selected";
    }

    this.submitBtnTarget.disabled = true;
  }

  selectImage(event) {
    this.imageTargets.forEach(image => {
      image.classList.remove(this.selectedClassValue)
    })

    const clickedElement = event.currentTarget
    clickedElement.classList.add(this.selectedClassValue)
    const imageId = clickedElement.dataset.imageId;
    this.inputTarget.value = imageId
    this.submitBtnTarget.disabled = false;
  }
}
