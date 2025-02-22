start_local_production:
	RAILS_ENV=local_production dip rails assets:precompile
	RAILS_ENV=local_production dip compose up
