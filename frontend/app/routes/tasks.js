import Ember from 'ember';

export default Ember.Route.extend({

  actions: {
    deleteTask(task) {
      task.deleteRecord();
      task.save();
    }
  }
});
