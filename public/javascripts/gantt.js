function update_gantt(gantt_type, gannt_id, duration, end_date) {
  if (gantt_type=='task'){ var action = 'gantt_save'} else {var action = 'gantt_milestone_save'};
  jQuery.post("/schedule/" + action + "/"+ gannt_id + "?duration=" +  duration + "&due_date=" + end_date);
}

var DateUtils = {
  daysBetween: function (start, end) {
    if (!start || !end) { return 0; }
      start = Date.parse(start); end = Date.parse(end);
      if (start.getYear() == 1901 || end.getYear() == 8099) { return 0; }
      var count = 0, date = start.clone();
      while (date.compareTo(end) == -1) { count = count + 1; date.addDays(1); }
      return count;
  },

  isWeekend: function (date) {
    return date.getDay() % 6 == 0;
  }
};

