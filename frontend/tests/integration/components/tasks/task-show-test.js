import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('tasks/task-show', 'Integration | Component | tasks/task show', {
  integration: true
});

test('it renders', function(assert) {
  this.render(hbs`{{tasks/task-show}}`);
  assert.equal(this.$().text().trim(), 'Delete');


});
