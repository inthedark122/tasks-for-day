import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'form',
  classNames: ['task-new'],
  store: Ember.inject.service('store'),

  actions: {
    add: function() {
      const store = this.get('store');

      const task = store.createRecord('task', {
        name: this.get('name'),
        description: this.get('description')
      });

      task.save().then(
        () => {
          this.set("name", "");
          this.set("description", "");
        },
        () => {
          task.deleteRecord();
        }
      );
    }
  }
});
