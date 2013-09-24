var processingJobs = [];

if (typeof gon !== 'undefined') {
	addJobWatchers();
}

function addJobWatchers() {
	if (gon.job) {
		gon.watch('job', {
			interval: 10000
		}, updateProcessingJob);
	} else if (gon.jobs.length) {
		gon.watch('jobs', {
			interval: 10000
		}, updateProcessingJobs);
	}
}

function updateProcessingJob(job) {
	if (job.processed) {
		gon.unwatch('job', updateProcessingJob);
		updateDocumentStatus(job);
	}
}

function updateProcessingJobs(jobs) {
	if (!processingJobs.length) {
		processingJobs = jobs;
	}
	doReset(determineUnprocessedJobs(jobs));
}

function determineUnprocessedJobs(jobs) {
	var diff = _.difference(processingJobs, jobs);
	_.forEach(diff, function (job) {
		updateDocumentStatus('td_' + job);
	});
	return !jobs.length;
}

function updateDocumentStatus(id) {
	var elm = document.getElementById(id);
	if (elm) {
		elm.innerHTML = 'Finished';
	}
}

function doReset(reset) {
	if (reset) {
		processingJobs = [];
		gon.unwatch('jobs', updateProcessingJobs);
	}
}