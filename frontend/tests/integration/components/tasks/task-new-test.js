import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

const task = {
  name: 'My first title',
  description: 'Task description'
};

moduleForComponent('tasks/task-new', 'Integration | Component | tasks/task new', {
  integration: true
});

test('it renders', function(assert) {
  this.render(hbs`{{tasks/task-new}}`);
  assert.equal(this.$().text().trim(), 'Add new task');

  this.$('.task-name').val(task.name);
  this.$('.task-description').val(task.description);
  this.$('input').change();

  //assert.equal(this.get('name'), task.name);
  //assert.equal(this.get('description'), task.description);
});
