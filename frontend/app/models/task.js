import Model from 'ember-data/model';
import attr from 'ember-data/attr';

export default Model.extend({
  name: attr('string'),
  description: attr('string'),
  started_at: attr('date'),
  finished_at: attr('date'),
  active_time: attr('number')
});
