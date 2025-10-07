import Component from '@glimmer/component';
import { service } from '@ember/service';
const TWEET_INTENT = 'https://twitter.com/intent/tweet';

export default class ShareButton extends Component {
  @service router;

  get currentURL() {
    return new URL(this.router.currentURL, window.location.origin);
  }

  get shareURL() {
    let url = new URL(TWEET_INTENT);

    url.searchParams.set('url', this.currentURL); // Añade la URL actual como parámetro 'url' para que Twitter la incluya en el tweet
    if (this.args.text) {
      url.searchParams.set('text', this.args.text); // Añade texto predefinido al tweet si se proporciona
    }

    if (this.args.hashtags) {
      url.searchParams.set('hashtags', this.args.hashtags); // Añade hashtags al tweet (separados por comas)
    }

    if (this.args.via) {
      url.searchParams.set('via', this.args.via); // Añade "via @username" al final del tweet
    }

    return url;
  }

  <template>
    <a
      ...attributes
      href={{this.shareURL}}
      target="_blank"
      rel="external nofollow noopener noreferrer"
      class="share button"
    >
      {{yield}}
    </a>
  </template>
}
