const deleteActivityFromActivities = (array, activity) =>
  array?.filter(a => a?.name_en !== activity?.name_en);

export default deleteActivityFromActivities;
