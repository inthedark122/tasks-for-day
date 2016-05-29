import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('tasks/tasks-list', 'Integration | Component | tasks/tasks list', {
  integration: true
});

test('it renders', function(assert) {
  this.render(hbs`{{tasks/tasks-list}}`);
  assert.equal(this.$('th').last().text().trim(), 'Actions');

});
