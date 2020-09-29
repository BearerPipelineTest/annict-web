import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['value'];

  valueTarget!: HTMLElement;
  charactersCounterId!: string

  initialize() {
    this.charactersCounterId = this.data.get('charactersCounterId') ?? 'id';
    this.boundUpdate = this.update.bind(this)
    this.valueTarget.innerText = 0
  }

  connect() {
    document.addEventListener('characters-counter:update', this.boundUpdate)
  }

  disconnect() {
    document.removeEventListener('characters-counter:update', this.boundUpdate)
  }

  update({ detail: { charactersCounterId, charactersCount } }: any) {
    if (this.charactersCounterId === charactersCounterId) {
      this.valueTarget.innerText = charactersCount
    }
  }
}
