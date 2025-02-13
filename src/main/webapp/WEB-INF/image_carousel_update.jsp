<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<c:set var="ctxPath" value="${pageContext.request.contextPath}" />

		<link rel="stylesheet" href="${ctxPath}/css/image_carousel_register.css">

		<c:if test="${empty imageList}">

			<div class="product-container">
				<div class="product-viewer">
				</div>
				<div class="thumbnail-container">
				</div>
				<span id="image_name"></span>
			</div>

		</c:if>

		<c:if test="${not empty imageList}">

			<div class="product-container">
				<div class="product-viewer">
					<c:forEach items="${imageList}" var="imageDTO">
						<div data-no="${imageDTO.pkProductImageNo}" class="product-slide" style="display: block;">
							<img src="${pageContext.request.contextPath}/${imageDTO.imagePath}" />
						</div>
					</c:forEach>
				</div>
				<div class="thumbnail-container">
					<c:forEach items="${imageList}" var="imageDTO">
						<div data-no="${imageDTO.pkProductImageNo}" class="thumbnail">
							<img src="${pageContext.request.contextPath}/${imageDTO.imagePath}" />
						</div>
					</c:forEach>
				</div>
			</div>

		</c:if>

		<script>
			let currentIndex = 0;
			let $slides = $('.product-slide');
			let $thumbnails = $('.thumbnail');
			let totalSlides = $slides.length;
			let touchStartY = 0;
			let touchEndY = 0;

			let fileList = new DataTransfer();

			$(document).ready(function () {

				// 첫 슬라이드 표시
				$slides.fadeOut(0);
				$slides.eq(0).fadeIn(0);
				$thumbnails.removeClass('active');
				$thumbnails.eq(0).addClass('active');

				// 썸네일 클릭 이벤트
				$(document).on('click', '.thumbnail', function () {
					const newIndex = $thumbnails.index(this);
					if (newIndex !== currentIndex) {
						moveToSlide(newIndex);
					}
				});

				$(document).on("click", "button#delete_image_button", function () {

					if ($slides.eq(currentIndex).data("no")) {
						const imageNo = $slides.eq(currentIndex).data("no");
						const productNo = ${productDTO.productNo};
						console.log(imageNo);
						deleteImage(imageNo, productNo);
					}
					else {
						$slides.eq(currentIndex).remove();
						$thumbnails.eq(currentIndex).remove();

						currentIndex = 0;
						$slides = $('.product-slide');
						$thumbnails = $('.thumbnail');
						totalSlides = $slides.length;

						$slides.eq(0).show();
						$thumbnails.eq(0).addClass('active');

						removeImage();
					}

				});

			});

			function moveToSlide(newIndex) {
				$slides.fadeOut(300);
				$slides.eq(newIndex).fadeIn(300);

				$thumbnails.removeClass('active');
				$thumbnails.eq(newIndex).addClass('active');

				const current_file = fileList.files[currentIndex];
				if (current_file != null) {
					$("span#image_name").val(current_file.name);

				}

				currentIndex = newIndex;
			}

			function readURL(input) {
				console.log("초기 fileList:", fileList.files); // 초기 fileList 상태

				if (input.files && input.files[0]) {

					console.log("선택된 파일들:", input.files); // 선택된 파일 확인

					Array.from(input.files).forEach((file, index) => {

						console.log(`${index}번째 파일:`, file); // 각 파일 정보 확인

						let reader = new FileReader();

						reader.onload = function (e) {

							const src = e.target.result;

							// 백틱이 아닌 따옴표로 변경하고, src를 + 연산자로 연결
							let product_image = '<div class="product-slide" style="display: block;"><img src="' + src + '" /></div>';
							$(".product-viewer").append(product_image);

							let thumbnail_image = '<div class="thumbnail"><img src="' + src + '" /></div>';
							$(".thumbnail-container").append(thumbnail_image);

							currentIndex = 0;
							$slides = $('.product-slide');
							$thumbnails = $('.thumbnail');
							totalSlides = $slides.length;

							moveToSlide(totalSlides - 1);

							fileList.items.add(file);

							console.log(`${index}번째 파일 추가 후 fileList:`, fileList.files); // 파일 추가 후 상태
							console.log("현재 fileList 길이:", fileList.files.length); // 파일 개수 확인
						};

						reader.readAsDataURL(file);

					});

				}

			}

			function removeImage() {
				const newFileList = new DataTransfer();

				Array.from(fileList.files).filter((_, i) => i !== currentIndex)
					.forEach(file => newFileList.items.add(file));

				fileList = newFileList;

				$("input#image_input").files = newFileList.files;

			}

			function deleteImage(imageNo, productNo) {

				$.ajax({
					url: "imageDelete.trd",
					type: "post",
					data: {
						imageNo: imageNo,
						productNo: productNo
					},
					dataType: "json",
					success: (json) => {
						if (json.message == "success") {
							alert("이미지 삭제를 성공했습니다.");
							
							$slides.eq(currentIndex).remove();
							$thumbnails.eq(currentIndex).remove();

							currentIndex = 0;
							$slides = $('.product-slide');
							$thumbnails = $('.thumbnail');
							totalSlides = $slides.length;

							$slides.eq(0).show();
							$thumbnails.eq(0).addClass('active');
							
							removeImage();
						}
						else {
							alert("이미지 삭제를 실패했습니다.");
						}
					},
					error: () => {
						alert("이미지 삭제를 실패했습니다.");
					}
				});
			}


		</script>