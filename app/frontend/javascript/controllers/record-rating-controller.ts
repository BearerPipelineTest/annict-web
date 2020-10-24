import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input'];

  element!: HTMLElement;
  inputTarget!: HTMLInputElement;

  changeState(event: Event) {
    const { state } = (event.currentTarget as HTMLInputElement).dataset;

    this.resetState();

    if (this.inputTarget.value === state) {
      this.inputTarget.value = '';
    } else {
      (event.currentTarget as HTMLInputElement).classList.remove('u-btn-outline-input-border');
      (event.currentTarget as HTMLInputElement).classList.add(`u-btn-${state}`);

      this.inputTarget.value = state?.toUpperCase() ?? '';
    }
  }

  resetState() {
    const buttonElms = this.element.getElementsByClassName('btn');

    for (let buttonElm of buttonElms) {
      const { state } = (buttonElm as HTMLElement).dataset;

      buttonElm.classList.remove(`u-btn-${state}`);
      buttonElm.classList.add('u-btn-outline-input-border');
    }
  }
}
