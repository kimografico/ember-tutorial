import { module, test } from 'qunit';
import { setupRenderingTest } from 'super-rentals/tests/helpers';
import Service from '@ember/service';
import { render } from '@ember/test-helpers';
import ShareButton from 'super-rentals/components/share-button';

const MOCK_URL = new URL(
  '/foo/bar?baz=true#some-section',
  window.location.origin,
);

class MockRouterService extends Service {
  get currentURL() {
    return '/foo/bar?baz=true#some-section';
  }
}

module('Integration | Component | share-button', function (hooks) {
  setupRenderingTest(hooks);

  hooks.beforeEach(function () {
    this.owner.register('service:router', MockRouterService);
  });

  test('basic usage', async function (assert) {
    await render(
      <template>
        <ShareButton>Tweet this!</ShareButton>
      </template>,
    );

    assert
      .dom('a')
      .hasAttribute('target', '_blank')
      .hasAttribute('rel', 'external nofollow noopener noreferrer')
      .hasAttribute(
        'href',
        `https://twitter.com/intent/tweet?url=${encodeURIComponent(MOCK_URL.href)}`,
      )
      .hasClass('share')
      .hasClass('button')
      .containsText('Tweet this!');
  });
});
