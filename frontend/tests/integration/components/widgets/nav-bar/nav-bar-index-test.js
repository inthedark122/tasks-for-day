import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('widgets/nav-bar/nav-bar-index', 'Integration | Component | widgets/nav bar/nav bar index', {
  integration: true
});

test('it renders', function(assert) {
  this.render(hbs`{{widgets/nav-bar/nav-bar-index}}`);
  assert.equal(this.$('li').first().text().trim(), 'Home');
});
