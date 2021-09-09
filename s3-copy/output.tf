output "script_content" {
    value = "${data.template_file.user_data.rendered}"
}