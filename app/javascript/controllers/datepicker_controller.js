import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      mode: "range",
      dateFormat: "Y-m-d",
      minDate: "today",
      onClose: this.handleDateSelection.bind(this)
    });
  }

  handleDateSelection(selectedDates) {
    if (selectedDates.length === 2) {
      if (selectedDates.length === 2) {
      const [startDate, endDate] = selectedDates.map(date => date.toISOString().split('T')[0]);
      console.log(startDate);

      const numberOfNights = this.calculateNumberOfNights(selectedDates[0], selectedDates[1]);
      document.getElementById('totalNights').innerText = numberOfNights;
      document.getElementById('nights').classList.remove('d-none');

      const roomPrice = document.getElementById('price').innerText;
      document.getElementById('total').classList.remove('d-none');
      document.getElementById('total-price').innerText = roomPrice * numberOfNights;

      document.getElementById('starts_at').value = startDate;
      document.getElementById('end_at').value = endDate;
    }
    }
  }

  calculateNumberOfNights(startDate, endDate) {
    const start = new Date(startDate);
    const end = new Date(endDate);
    const timeDifference = end.getTime() - start.getTime();
    const numberOfNights = Math.ceil(timeDifference / (1000 * 3600 * 24));
    return numberOfNights;
  }

}
