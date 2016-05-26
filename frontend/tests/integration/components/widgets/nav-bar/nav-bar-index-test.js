import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('widgets/nav-bar/nav-bar-index', 'Integration | Component | widgets/nav bar/nav bar index', {
  integration: true
});

test('it renders', function(assert) {
  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{widgets/nav-bar/nav-bar-index}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#widgets/nav-bar/nav-bar-index}}
      template block text
    {{/widgets/nav-bar/nav-bar-index}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
