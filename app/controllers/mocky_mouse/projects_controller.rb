module MockyMouse
  class ProjectsController < ApplicationController
    def index
    end

    def new
      @project = Project.new
    end

    def show
    end

    def create
      @project = Project.new(project_params)
      @project.user = current_user

      if @project.save
        redirect_to mocky_mouse_project_path(@project), notice: 'Project was successfully created.'
      else
        render :new
      end
    end

    private

    def project_params
      params.require(:mocky_mouse_project).permit(:name, :endpoint, :description)
    end
  end
end
