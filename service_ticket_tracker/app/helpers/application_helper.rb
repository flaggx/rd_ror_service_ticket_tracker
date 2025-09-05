module ApplicationHelper
  # Tailwind-aware nav link that highlights when active
  def nav_link_to(label, path, active_exact: false)
    is_active =
      if active_exact
        current_page?(path)
      else
        request.path.starts_with?(path)
      end

    base = "text-sm font-medium"
    normal = "text-gray-300 hover:text-white"
    active = "text-indigo-400"

    classes = [base, (is_active ? active : normal)].join(" ")
    link_to label, path, class: classes
  end
end