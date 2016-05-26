import Ember from 'ember';

export default Ember.Component.extend({

  actions: {
    deleteTask(task) {
      this.sendAction('deleteTask', task);
    }
  }
});
